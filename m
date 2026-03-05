Return-Path: <netdev+bounces-264188-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEmXOU8eqWmL2QAAu9opvQ
	(envelope-from <netdev+bounces-264188-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 07:10:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A7220B25B
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 07:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6EFE130603C2
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 06:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C43328A1E6;
	Thu,  5 Mar 2026 06:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="nqeKs0xB"
X-Original-To: netdev@vger.kernel.org
Received: from sg-1-103.ptr.blmpb.com (sg-1-103.ptr.blmpb.com [118.26.132.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E2B28F935
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 06:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772690985; cv=none; b=IfBioCJ+FjpfB8jZc5fLTtj0MbZXh0R9eupaiuqejjpGF2MEiF+uMikcQ70BlytRpf0qWvr3uyO2SKWADRAnUxrPtn9VYyWbb5zrm/3h2t9GaAFdA/vE5cTYl/LiW/LBEqxy5bqF/JRFwhN8MMwD6sxTCdhM+k8IoMsn27JeWmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772690985; c=relaxed/simple;
	bh=KVasOPL7u+DV2EzkfDfph2oiVBpb5mqzmurwZM4PaaY=;
	h=Message-Id:From:Subject:Date:Mime-Version:In-Reply-To:Cc:To:
	 Content-Type:References; b=P84wvrBXbWBmsOylTVl9JqfWTKGSWfTfF4tbk+Xeq009JFRAz7OL2xF0hFYQnYXlWIkBtYGr/E/XDq9UesjtcSxUjBmWlrPLloWplf2VkRryO5asCUGi4rnR6uAw/cInJh9jOQ/iKoTcGWQxj6Cw6UHo0g9cL48LagGRvaVkkxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=nqeKs0xB; arc=none smtp.client-ip=118.26.132.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1772690973; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=+BWZ6W0a9ZXraBQ8fHLzrXsMFF6QW/RZXOUx82k65pc=;
 b=nqeKs0xB31iqSjl2pn1AAs6DJxXjw30Xn8eQNYQMTfpzdI+z6SttmTx5exYd5cjDygS9Aq
 hEfNeaxanY6jwCq/gz6bfPJORjC1Inuo+vgLyA+fq6IWJSYcYA8t3s41vaGB4eTYIp8L/E
 htAZ6gcX7vAsJage2WDPLhFouUgqqCQj2crvPCr1+Bp5kpwmfgpNRTpkQR84PBLgFT8o5i
 VypH+XKpyIrJ7Z1ribpfnHrUetTH8SKZxYLKPTMZpQgQZs+cy5GV62TygGEwnXGJ5CKJ6T
 flTsYAXWYk1pN97I1PkuiXFtF9nrmXql8TYQnnOswh7TkYlo8neJ+piF0b6Wyw==
X-Original-From: ByteDance <zhangjian.3032@bytedance.com>
Message-Id: <24A97186-F1AC-4CA3-827F-95849C73B820@bytedance.com>
From: "ByteDance" <zhangjian.3032@bytedance.com>
Subject: Re: [PATCH net] net: ncsi: fix skb leak in error paths
Date: Thu, 5 Mar 2026 14:09:02 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <20260304164555.6253faf3@kernel.org>
X-Lms-Return-Path: <lba+269a91e1b+860f3d+vger.kernel.org+zhangjian.3032@bytedance.com>
X-Mailer: Apple Mail (2.3776.700.51.11.4)
Cc: "Samuel Mendoza-Jonas" <sam@mendozajonas.com>, 
	"Paul Fertser" <fercerpav@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, 
	"Eric Dumazet" <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>, 
	"Simon Horman" <horms@kernel.org>, <netdev@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>
To: "Jakub Kicinski" <kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
References: <20260302054629.1347119-1-zhangjian.3032@bytedance.com> <20260304164555.6253faf3@kernel.org>
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 94A7220B25B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=2212171451];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264188-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[mendozajonas.com,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bytedance.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangjian.3032@bytedance.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:dkim,bytedance.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Thanks for the review. I will send a v2 with these changes


> 2026=E5=B9=B43=E6=9C=885=E6=97=A5 08:45=EF=BC=8CJakub Kicinski <kuba@kern=
el.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Mon,  2 Mar 2026 13:46:29 +0800 Jian Zhang wrote:
>> +bail:
>=20
> please give meaningful names to the labels, eg:
>=20
> err_free_skb:
>=20
>> + consume_skb(skb);
>=20
> since this is a drop condition kfree_skb() seems more appropriate.
>=20
>> + return ret;
> --=20
> pw-bot: cr

