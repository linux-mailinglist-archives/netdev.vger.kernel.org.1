Return-Path: <netdev+bounces-269325-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDr/C/Seu2nplwIAu9opvQ
	(envelope-from <netdev+bounces-269325-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 08:00:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A472C7021
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 08:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD4403036083
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 06:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A50736BCEE;
	Thu, 19 Mar 2026 06:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exuwoF0A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AF736BCD7
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 06:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773903594; cv=none; b=ZQmPAcf6In4ywaNQzJ8N9OJxPQrJUcjHwNEhrvMjTEUA/jmgSu/zRz3TyFnClAbC477w8A8PRtC/6JIStf8/8T7erd1cz7LuV7t5iSQxuodA1DWPjGFMmV6PPJ7sef/UUlNTPC6HEq4l7DL+Nu1qdMOur8O12VYMQf5eBqGcGvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773903594; c=relaxed/simple;
	bh=FUvX8ECzFfxYtqPQhu3PpDPugdXoRG6qyzyFEeiQjH0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=HWwUab1VAEdAxDvE9iwMRpJz0FBdn4ifZFFcWG6J54PRDdbaGqMcWZKmdnV4Fwc37Q0dgV6jNCmJPER4uaeEoyQcK+r1Al2MaVrlcKf0q+//yWiVOHEIaHvYF4E8IsplQ/wmoyZ/MtWz4jFuGZf2R9Gzhz3rbWZ6NIaoC2cLSJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exuwoF0A; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-485445e80bdso4851785e9.0
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 23:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773903591; x=1774508391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=msryOGvr4NC55DltH+ndeevRjDMkTOjiTqGi0cNMcpI=;
        b=exuwoF0AVvhO4Oi316xW70K1JaJI9WQ15LmA8v26D1TEzI0PjnvUuip9/A+nQuV9/r
         ckHXWyaaslBGhdi0FFTfIm/mCM77eUXLkrHpcCzSJ9njhv37oYA5foCVTCVfDxaF2c5l
         wS2kLiIANQT/umy/j9T4YCiZg5+OwNIpvWQelSRRLLSXewF2m1i3ddzaB7/1+9Nluz2J
         cec7Y/8d3Ge1Aynja45j1q0wKW43EZcfd3ZRmdnIp5k9+UwKUSvQaFV9wfDF8CbbSH26
         6h6ftIPp75nOv6mKmVQVgOrxV0k8cPPbCnaJqwxKNFBlzkp7g5RAD3+06wMdl1lSjemq
         TQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773903591; x=1774508391;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=msryOGvr4NC55DltH+ndeevRjDMkTOjiTqGi0cNMcpI=;
        b=nFPcOpV+cWmOF3KJJBArxhq9a5TtM7iKg5xZHKHTPEavyUn3yXV5n5fQ2IHpBnd+ua
         V9Bw0SeS56268Rh4CZ4l0pMMHRa48eACcv5knxQ5zyYF/cQwuc3N+AGg2Jkg6164NAhO
         VuccKLCuAb+X4Roygq5x6xRHpmMjQ75kP6GeFTtKXo5iZFk9XgMyiE77wbmkQ4IJMyJX
         ZpEwQsvpaD1TMeU/Ab4udNXCHt6h79UazMSU+Hf7k3RxEv0v6YeNTVHLdr3SQR4hTZ7H
         ctSIsSbbGmjrntwL2sl06uDNyRT+na8lkSQLDpXUoZUQ2M02S/rYow9AJjvfvD4SdAm9
         4f2A==
X-Forwarded-Encrypted: i=1; AJvYcCV6uIhHHuETL+8sRj1hhF3+jZvFV5wUH3Un5lbkDKyjnTKEFO1vKKaEPd3Li8tox5LM4Nd19B0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWoyxmZ3GgMX8roNEHFitzfQqXrWsxCJLdX4TirfxgWHsowNYU
	K7hY6wy1fnbXjgRcgvZZB8V8FtPwe744Bj2zdogBIDajkUr87cQPbrjfiJ3HUQ==
X-Gm-Gg: ATEYQzxt6qKHUuVWz8Z9Rk8CD2SAUWSzd6uLDdudtThhfacQpBw0rVKeu3sVvBDJXVY
	fdKAq8zkPgP2yZgsRFIymbWaxiBVmpqbje4ubGJdqTE2D2ED+18Vl890JpBS/DDnPBOl/3wlZsD
	78icZWY3WVuFpk5ZNS9cQZdgoOgFTaBD+Hc+MOj19lLA6Nr71gnkE1befMCwcIj8bQUCwpcUXF1
	6W8aLtL3X6ZuyHeABR/T4iaRsy6LKvsijGTXKOgmjoredmYPcciT9bDvht2vD0a473GJ+tNpVTX
	OTCmNUGJwAOzfnOPNPkQbhSsfi63CHcT7V+u2Zhij5aGXCPlTNqjy1AvUrbVG/5madPeYwRakCA
	h0W37igql3uyo14Lal0JY+a8E+PoYj62QFcM4cT5JEJ2/k6zFpAIVP4DGHui6kGX0vT7Mv7LDOm
	1BRiue1pz7TudqFQELTC5hwt3LuEoM0FY759M=
X-Received: by 2002:a05:600c:45d5:b0:485:345b:ccb1 with SMTP id 5b1f17b1804b1-486f4579cf2mr94299905e9.27.1773903590917;
        Wed, 18 Mar 2026 23:59:50 -0700 (PDT)
Received: from ehlo.thunderbird.net ([80.244.29.143])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f4b810bcsm36050495e9.15.2026.03.18.23.59.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 23:59:50 -0700 (PDT)
Date: Thu, 19 Mar 2026 08:59:47 +0200
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org
CC: Johannes Berg <johannes.berg@intel.com>,
 Loic Poulain <loic.poulain@linaro.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net_1/2=5D_rtnetlink=3A_count_IFLA=5F?=
 =?US-ASCII?Q?PARENT=5FDEV=5F=7BNAME=2CBUS=5FNAME=7D_in_if=5Fnlmsg=5Fsize?=
User-Agent: K-9 Mail for Android
In-Reply-To: <c8acbb1f4f3651f50fc4f5ddee234f1ea6769588.1773829376.git.sd@queasysnail.net>
References: <cover.1773829376.git.sd@queasysnail.net> <c8acbb1f4f3651f50fc4f5ddee234f1ea6769588.1773829376.git.sd@queasysnail.net>
Message-ID: <F93F0AB8-E659-412B-AE27-83488A711490@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.96 / 15.00];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269325-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryazanovsa@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.857];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B9A472C7021
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On March 18, 2026 12:45:52 PM, Sabrina Dubroca <sd@queasysnail=2Enet> wrote=
:
>Commit 00e77ed8e64d ("rtnetlink: add IFLA_PARENT_[DEV|DEV_BUS]_NAME")
>added those attributes to rtnl_fill_ifinfo, but forgot to extend
>if_nlmsg_size=2E

Nice catch! Please find an implementation question below=2E

>Fixes: 00e77ed8e64d ("rtnetlink: add IFLA_PARENT_[DEV|DEV_BUS]_NAME")
>Signed-off-by: Sabrina Dubroca <sd@queasysnail=2Enet>
>---
> net/core/rtnetlink=2Ec | 16 ++++++++++++++++
> 1 file changed, 16 insertions(+)
>
>diff --git a/net/core/rtnetlink=2Ec b/net/core/rtnetlink=2Ec
>index dad4b1054955=2E=2Ea116362f5f32 100644
>--- a/net/core/rtnetlink=2Ec
>+++ b/net/core/rtnetlink=2Ec
>@@ -1267,6 +1267,21 @@ static size_t rtnl_dpll_pin_size(const struct net_=
device *dev)
> 	return size;
> }
>=20
>+static size_t rtnl_dev_parent_size(const struct net_device *dev)
>+{
>+	size_t size =3D 0;
>+
>+	/* IFLA_PARENT_DEV_NAME */
>+	if (dev->dev=2Eparent)
>+		size +=3D strlen(dev_name(dev->dev=2Eparent)) + 1;

Shall we use nla_total_size() to account alignment?

>+	/* IFLA_PARENT_DEV_BUS_NAME */
>+	if (dev->dev=2Eparent && dev->dev=2Eparent->bus)
>+		size +=3D strlen(dev->dev=2Eparent->bus->name) + 1;
>+
>+	return size;
>+}
>+
> static noinline size_t if_nlmsg_size(const struct net_device *dev,
> 				     u32 ext_filter_mask)
> {
>@@ -1328,6 +1343,7 @@ static noinline size_t if_nlmsg_size(const struct n=
et_device *dev,
> 	       + nla_total_size(8)  /* IFLA_MAX_PACING_OFFLOAD_HORIZON */
> 	       + nla_total_size(2)  /* IFLA_HEADROOM */
> 	       + nla_total_size(2)  /* IFLA_TAILROOM */
>+	       + rtnl_dev_parent_size(dev)
> 	       + 0;
>=20
> 	if (!(ext_filter_mask & RTEXT_FILTER_SKIP_STATS))

--
Sergey
Hi Sabrina,

