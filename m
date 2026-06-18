Return-Path: <netdev+bounces-300488-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fQ78DegbNGr2OgYAu9opvQ
	(envelope-from <netdev+bounces-300488-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 18:25:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A15F86A194A
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 18:25:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hWeIyDmh;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="8x/SzGu6";
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AjeSmqS7;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=F6hU66nN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300488-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300488-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 687EE30073F1
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 16:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441433148D3;
	Thu, 18 Jun 2026 16:22:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05E92E091E
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 16:22:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781799764; cv=none; b=V9ma9hFTKCEvF578ShUoI6qDbxcisXgoUsKY4/N6QY2FhFoigIXeC7Fr6TxZz7eBHu4Nn2R5ltqrxLZZpf/lvb/A5Nm/NpbyJgDr11IKKz2tCj6Znk8PCMPYij8ILYuBrJfSr7+8DQrL3eV3+C86esfjMuJwwovqoJMUnGH2+oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781799764; c=relaxed/simple;
	bh=DeZY7vy0HPv+7TCzuVbQuh8QCWvkxjZ/A7rt97OaWa8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AwH+EIu44YXa77kewhMVjPTPVjghx32AbPSbcFmUBJYq5G5JZDfUnEbbKta4viuxQYZgziEOOzEuoaX291G/zWm6+rLq6LB9jtJtH2ydozvzf5lcHQyLp0xuHl/ILHWO+ELPcgEcxRTlxKEVyOwEm0XJwacDsKtCAMNo8ScHVJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hWeIyDmh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8x/SzGu6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AjeSmqS7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=F6hU66nN; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C5B9E6D3B1;
	Thu, 18 Jun 2026 16:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781799757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=N583wkjT9FfAHpnTaqecd0J7emPmTiOyMIfo3A6eenc=;
	b=hWeIyDmhEra0LYF1jGA4xAnwelv+BLtbz1Gbcdlo47zPA+NYhrzk31qejKyVo9V3weiFPp
	oQ3pTElXWgrP/JaEeLC29Tfqi5kA63RLxCuVAxYAo041E4axUDO90CoM0HmUXmeUFi3Uy3
	0DwjflXT0MxwaztgEuOcEWJRJ0AmJDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781799757;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=N583wkjT9FfAHpnTaqecd0J7emPmTiOyMIfo3A6eenc=;
	b=8x/SzGu6Vgm23b82G11Q6UwDefvyS6v2xJstPJQ3G2aRGwzzo1ncOnja4gMLrwQGUawq6s
	r6985oJLO46W6mBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781799756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=N583wkjT9FfAHpnTaqecd0J7emPmTiOyMIfo3A6eenc=;
	b=AjeSmqS7Gy67NjrKgJ4joRncz7GhGh36pFPwSwChdsTo4e6J3DfagAVmTnnwwbZGqxnWZq
	vJS2EejMhAXJEa7vppgEm9qRi/upuHf2JrL6ah1HpsbRwws/7x9XnhXIZDvkQMW6CvLAsv
	j8gj5e51lFxu2VabUTCSQrq3a1MHasw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781799756;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=N583wkjT9FfAHpnTaqecd0J7emPmTiOyMIfo3A6eenc=;
	b=F6hU66nNn1k3pYoreMi3BslQVf8AXlrhN81BQFlKAovd5tx7atQ7nFlbTquWWkqHCIevUA
	3GH9DNfmfrejsMAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5984779A8;
	Thu, 18 Jun 2026 16:22:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8Hq4MEsbNGqCDgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 18 Jun 2026 16:22:35 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: nicolas.dichtel@6wind.com,
	shemminger@vyatta.com,
	dforster@brocade.com,
	gospo@cumulusnetworks.com,
	ddutt@cumulusnetworks.com,
	brian.haley@hp.com,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	idosch@nvidia.com,
	dsahern@kernel.org,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH net 0/6] ipv6: fix sysctl error handling and missing notifications
Date: Thu, 18 Jun 2026 18:22:19 +0200
Message-ID: <20260618162225.4588-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300488-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:nicolas.dichtel@6wind.com,m:shemminger@vyatta.com,m:dforster@brocade.com,m:gospo@cumulusnetworks.com,m:ddutt@cumulusnetworks.com,m:brian.haley@hp.com,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:idosch@nvidia.com,m:dsahern@kernel.org,m:fmancera@suse.de,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A15F86A194A

While working on a different IPv6 patch series I have spotted multiple
minor bugs around sysctl error handling and notifications. In general,
they are not serious issues.

In addition, there is one more issue in forwarding sysctl as it does not
check for CAP_NET_ADMIN for the namespace. I am keeping that patch out
of this series and I am aiming it at the net-next tree once it re-opens.

Fernando Fernandez Mancera (6):
  ipv6: fix error handling in disable_ipv6 sysctl
  ipv6: fix error handling in ignore_routes_with_linkdown sysctl
  ipv6: fix error handling in forwarding sysctl
  ipv6: fix error handling in disable_policy sysctl
  ipv6: reset value and position for proxy_ndp sysctl restart
  ipv6: fix missing notification for ignore_routes_with_linkdown

 net/ipv6/addrconf.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

-- 
2.54.0


