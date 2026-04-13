Return-Path: <netdev+bounces-278063-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMPoCCne3GnrXgkAu9opvQ
	(envelope-from <netdev+bounces-278063-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 14:14:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C0C3EBC2A
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 14:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5AC330342A9
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 12:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C82C3C3443;
	Mon, 13 Apr 2026 12:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="k4ACmIf5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000C62D94A0
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 12:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776082136; cv=none; b=qKS3UydIVU9maXl4cxz++REux9skDk57ulmpNp1DqPHFLW4MVOqRzk4IBUuvlJO6evXFHFqzrYFN7wJhY4GYd15Eykl9DgLn9WoTrGGfTfJouu3AV5X9mawIgdtv+vgJ/U2cgk5hl4C/xWfVmiKs0NGJhSkOkwnnWorjQSluWY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776082136; c=relaxed/simple;
	bh=b2oAs+7vRWLLh/ZhqKcI6Wf3Rh+33ekKWwGwtI3FYVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z0BiVStPb/zxNWIu1R/IhyhCMoepONEgEzuakuiMouUsozeVAd1iq6bzhzKvfl3j6zEzPmzd4iXKyx2Aqjikcf1s/lV3yFxIRaHkM19rXnGn0/q7Xsn18yBgNUB80zoR3IgY2BNNyNnrefOCAa0E6g4+EjAuuXeWMa6lDzINZc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=k4ACmIf5; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488ba6366a7so54551535e9.0
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 05:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1776082131; x=1776686931; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IRwudnmggZ/XUXjz8Dn4rqFQM8+32hzeX1Hgry14NgQ=;
        b=k4ACmIf5ffGmWi25liCp2Y6LH8mtiV1g5BEtmb7iIfZPGvdtIpx0Mvk2NkOztVPAPG
         2r5I7/yTDgAm/f+bhugfjKSDmWyzUYtCUbeSFRa4cNOv6VjHZzyJJ5SOuvbsyGFit7ns
         Ox9oZ3dD3kIyW09hT3vah6mnnlo2OPNmpWfMuFiISGdCLx+OIam2Tkq/Kyq9gENQ3M/n
         vy+8TDGe5MPyTwLCydwX9rryjOhsmN9ii1O+HHUgvfo/sUuHkqLj8f56u7L58E9ZJ1Ey
         EFkt3DX/PFB9EPKS04nKU7yQVLxEuHKSKUqQsOK6sn86Hiie/LVXc3f2PJe3gID9CguH
         7Zcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776082131; x=1776686931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IRwudnmggZ/XUXjz8Dn4rqFQM8+32hzeX1Hgry14NgQ=;
        b=Tin4W/hwW5lstSFLQhKjffaQ24c59TBYAMOHRL0mYxEA8VzGPZC4SAXkMJhBjIEQ1Y
         1nbC16uEpEydEVmvnntpt2W80NSIXl2orUP0cAka4ST7nqH2C2pIDhPkykyuWMjE66+v
         v0kwL2CJ8KQRen0u3hRRZZyVlFnqLxo3jeDXa7tbY39+8Vqhvu4aaTTW8lqk2nVt7ic6
         ACueA7u3zNqdddFNe7sExocMwzxVJ/4wbxHYquQ9eQdfSqoMdMD6v2utVfJrED6WiRJu
         mjDYCxZWhB9zLTc/1NB5apkIM4zc8Ee3HmPfc2kXK7UkCU4SjGE/OY3EL+AHez+gv/bL
         QgLA==
X-Gm-Message-State: AOJu0Yw2yXJn1xbpqNT+VX4X0F1grA2aPU+xe7xtIU5/PAlip8VRxZe1
	pk2RNXlpcEczcbFTJj4AQdxrj1dRpH3Yjy9ELOH5sJMsxAFzSbn6+c4ymPt9a4x7c7rlgehqFE2
	zvLxY
X-Gm-Gg: AeBDies4poZjddRtOO7GF9so5ZTtMrFcdQQdcOR7kmtHVy9EjoBpXafvPsTNSvJgbq9
	gdtrLOz4SeQIv3v7gX8xjvK3MK3P//YbUCUL5UnV+xg2d+p7w2bHq6xNzXbr2vvZTJiVXQggYqN
	C8mQ6bOzkC302osnuXTSRPkkcdTwcB/yqyv+KUVAIddeeTOd6SOSs3sMSrsO8x2g9+5/0Ugaz+T
	EImO/WT8F485etYWUkDpYGWXhD61ChcYNTTpetKJzrun77NodvgK4VOg4K12vyRHjKanm/tIZLx
	ITL3han2SuLEVombmzH5qp+AOuEKWt41Q7Uj7x8JEUBm3qNJ2lmL+ThkruQ9IDEqMGT2YV7FWxL
	2AS/JlAE3ZGWZ352JKzoq8FAqloBkpuoaHa/smyCEPFVrwDfwo70+2Qh51yaevWjzfFgqbQu8uN
	nFA4atU1d8lfG0wDeWvr7bSykQ52BgAP4=
X-Received: by 2002:a05:600c:3149:b0:488:ab26:8fe0 with SMTP id 5b1f17b1804b1-488d68432f2mr183678385e9.15.1776082131150;
        Mon, 13 Apr 2026 05:08:51 -0700 (PDT)
Received: from FV6GYCPJ69 ([208.127.45.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d68479b2sm92668315e9.25.2026.04.13.05.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 05:08:50 -0700 (PDT)
Date: Mon, 13 Apr 2026 14:08:47 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, sgoutham@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, donald.hunter@gmail.com, 
	horms@kernel.org, chuck.lever@oracle.com, matttbe@kernel.org, cjubran@nvidia.com, 
	saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com, 
	dtatulea@nvidia.com
Subject: Re: [PATCH v11 net-next 4/7] devlink: Implement devlink param multi
 attribute nested data values
Message-ID: <3pk4hkzgwy3a55zveapgmk23bsevru55xv75vhkzbpmzkfofcx@rlnkrvynofig>
References: <20260409025055.1664053-1-rkannoth@marvell.com>
 <20260409025055.1664053-5-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409025055.1664053-5-rkannoth@marvell.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278063-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,marvell.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,oracle.com,nvidia.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 78C0C3EBC2A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thu, Apr 09, 2026 at 04:50:52AM +0200, rkannoth@marvell.com wrote:
>From: Saeed Mahameed <saeedm@nvidia.com>

[...]


>diff --git a/net/devlink/param.c b/net/devlink/param.c
>index 4595fffbd825..8c9165797b32 100644
>--- a/net/devlink/param.c
>+++ b/net/devlink/param.c
>@@ -252,6 +252,14 @@ devlink_nl_param_value_put(struct sk_buff *msg, enum devlink_param_type type,
> 				return -EMSGSIZE;
> 		}
> 		break;
>+	case DEVLINK_PARAM_TYPE_U64_ARRAY:
>+		if (val->u64arr.size > __DEVLINK_PARAM_MAX_ARRAY_SIZE)

From UAPI perspective, what's the motivation for such limitation? I
don't think we need it. Whatever kernel/user fits into skb is okay, no?




>+			return -EMSGSIZE;
>+
>+		for (int i = 0; i < val->u64arr.size; i++)
>+			if (nla_put_uint(msg, nla_type, val->u64arr.val[i]))
>+				return -EMSGSIZE;
>+		break;
> 	}
> 	return 0;
> }

[...]

