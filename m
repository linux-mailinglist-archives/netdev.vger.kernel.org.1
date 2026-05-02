Return-Path: <netdev+bounces-283452-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LoMCA819mk5TAIAu9opvQ
	(envelope-from <netdev+bounces-283452-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 19:31:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9BA4B30EE
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 19:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28CDE300CE79
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 17:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5682A346E46;
	Sat,  2 May 2026 17:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGyfBsqb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340B81531C8;
	Sat,  2 May 2026 17:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777743116; cv=none; b=sHgrbP4X15iRDxdbu+ysvhMBKjWKdBCSXxHmMpr9aE+rtjOrXgWfAV/GQ7TSM2Mt3al6EwxVR2gaqqto+msP4oHBOpru8MIYhDGAOxKsCdQ+OIqzRSXC6nW9g/65BEsCpM9XMsxBrOBt04XQp6HRrDme3E8Wrp6Mz05Ci1aHj+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777743116; c=relaxed/simple;
	bh=FO6nMcMn/OGU6uVS1myEZJa/Wri94sywk/kufi7znt0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q2JDDq749vq1NLP+L+/wTlIF5zf7mP3dQFLKQd9Iqay0sO5oR0FNWkRG4LiK6DCovD35KBFq8ZcR+aAx26WrRvwaOYvYCj9+5rGu4/NsASdYdtTu3Sh3Ae8g+Y37Y80PhmgiMC87RB7k6uRCYCbqQuRRv3nJSYymS3rrPY/3ZwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGyfBsqb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406F3C19425;
	Sat,  2 May 2026 17:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777743116;
	bh=FO6nMcMn/OGU6uVS1myEZJa/Wri94sywk/kufi7znt0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gGyfBsqb83MA8IoSJM0udPhNHy69AFryi5X9Dy1SpE2tZSuT/RBvrQY5Jn8npArWI
	 QP/NC9fNm24xkYgn8Bc05tSVeeZtoUka8ZdRvW18FspJFWxkn3seyZT4U0kYaR8CMJ
	 +gwG8EoHsCXuoxKx0lpsT5HE00uMHmF8H8RaJvBZBJC3tyXPNQ/d8PrXnWlwqyqNR8
	 DrSB6NndZGdyyaIZ5XhkoV5z9qHxyO3C3UNF63S9CkRQtWLcyYM6+rIFH1Bc7AFbV6
	 A5driE33UrVCc19Qicg/o0+tgPvcOtOV4Xg15JBzeO65GG693lGKrq+ayDHXa3uOjh
	 DxIDhfFia9WPg==
Date: Sat, 2 May 2026 10:31:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, poros@redhat.com,
 richardcochran@gmail.com, andrew+netdev@lunn.ch,
 przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com,
 Prathosh.Satish@microchip.com, ivecera@redhat.com, jiri@resnulli.us,
 arkadiusz.kubalewski@intel.com, vadim.fedorenko@linux.dev,
 donald.hunter@gmail.com, horms@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH v7 net-next 3/8] dpll: extend pin notifier and netlink
 events with notification source ID
Message-ID: <20260502103154.71b4b5de@kernel.org>
In-Reply-To: <20260430094238.987976-4-grzegorz.nitka@intel.com>
References: <20260430094238.987976-1-grzegorz.nitka@intel.com>
	<20260430094238.987976-4-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6C9BA4B30EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283452-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,resnulli.us,linux.dev,kernel.org,davemloft.net,google.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Thu, 30 Apr 2026 11:42:33 +0200 Grzegorz Nitka wrote:
> Subject: [PATCH v7 net-next 3/8] dpll: extend pin notifier and netlink events with notification source ID

As AI points out you're only adding this for the internal notification,
but the commit title mentions netlink too. If we don't need it in
netlink we can just drop the references in the commit msg?

