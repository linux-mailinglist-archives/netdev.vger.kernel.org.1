Return-Path: <netdev+bounces-278041-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YL1RE3HN3GmcWQkAu9opvQ
	(envelope-from <netdev+bounces-278041-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 13:03:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D70513EB0D4
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 13:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B79B304CA77
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 10:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4F63AB291;
	Mon, 13 Apr 2026 10:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GQw7DBoL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cAj49iQU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8691432D0DC
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 10:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776077688; cv=none; b=bTGvv5S8RUDOnbyIpnr8Dv3I9rTK1w76mBA3fqNSoEgsQYVGHPJaXYLiV+AzHcSuItJ75ltUrBDJ5K5tR/JgjUsWW2WOrpG224ky20CoE/leZwMAH0kzpTno97FtgBjwTbXE80qNm4h62DfyFlK+PDTqBVe8aL1sAjAz+VJY+n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776077688; c=relaxed/simple;
	bh=7+YjL1Z3bliScwUng4CAgMvZeA+XTj9Uy5vlgmuleaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FflUbYaN0an21Cf0RkpyWr5Qx+TCbE6gzxihZpR3EemyzjFlRHNLgdQafnsz9Od5eHzq3/glMErrPj9t2JQdf8LoERZvIZpVRidb6jsdPgbmH4jWEPcwkKRx3x859RyANn2Yya0seO3cxo6WZaYxTHcdaw1dh2odw6DhNJhypzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GQw7DBoL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cAj49iQU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776077686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IKCpi0TWT23M9KWAsaLDSoUOdYRB6FuK4otIQkaBnmY=;
	b=GQw7DBoLzzAvS2E2gkfsGNm0k/ZH0Ew4yTx1ShwcXK2RUp84DRZt6i4oFTpdAXcXvLNXKB
	LrfzX3ly0Gsz8XY1OJXnasYfZ5hCYzALe/pvS2+3OYhT8Mf6WgL0YRLbx8c11+bE1p3iEo
	JPRGZHf5Zc+LZcUlvSwar882Uu1gtn8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-2IoMcmQSOP2AvlheO2rf4A-1; Mon, 13 Apr 2026 06:54:45 -0400
X-MC-Unique: 2IoMcmQSOP2AvlheO2rf4A-1
X-Mimecast-MFC-AGG-ID: 2IoMcmQSOP2AvlheO2rf4A_1776077684
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488dcff87b7so10638755e9.2
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 03:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776077684; x=1776682484; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IKCpi0TWT23M9KWAsaLDSoUOdYRB6FuK4otIQkaBnmY=;
        b=cAj49iQU4/Q7cdKzb3r804EkjpsQrtO5Wy/dPbnGoFadrJWKoEDKm8+OMNdaPgcXqR
         zo7KLxW811HFb0NPG/gYGRFh16ZThl9prRVDzfKsqyzihAroUE77fU6o3ILVesnITrpo
         +KhDQ/zc3zYcN6nvswRZ8E/T5fom4x5ummlYN6va68S9+Lb9YOfnwgGI5V4FvXjq8DVk
         /7Mq67UTUD+292/hWSInHtgp7hJUo2fKws88P6K1IyeKgxXJ/QOEGAHEV77BxcSoiqm3
         QCTwah9KWmwLZwqyX1wdCyiT3Tv+PqvJtmN93LWJTfPWA1J5cfY/PjyV6FHsn2ZaC/51
         hT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776077684; x=1776682484;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IKCpi0TWT23M9KWAsaLDSoUOdYRB6FuK4otIQkaBnmY=;
        b=ByJwlXhiBZuFk83Fejyil6wG8d3EJBC5liYaFyxOq5j2ZyI6CUxuMtJE0g0r2W0E1p
         AGZEOxz1pPJsQZkCayYMUT3Lc0xzsHRNdLG1WlhNmniH2IgsBxAtrDUjtITeCVUQEmLW
         0CRPtPFiQ54rBeaBjdeNMGc7hwYrxomuucTFcvDjwVyu4dCUt/RLeIIQnTCTBoTk5IQT
         YSq1D4Y/I2uEbUXP5wDXADZviuNcfevGwGmoQRf1XSyRl/oQnFSspIThkqvRbX+DUzF+
         M69/jFhU7B9WLsecrYJOpEa1MHLXDzX6gfyGCOp4muV6EU4ExCdvFPNl9hA+UcPX+QUm
         IhYg==
X-Forwarded-Encrypted: i=1; AFNElJ/kefpqBrSuenzt9atBBMplo+NwKGqFddcAPPW7EaOxmKQ9KWA26qkMbuCEjdVy2xkK5r3JzG0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl7yyCYZJrk9tsj1EKFMHFL6aRGPAsx7AmxIkdOFZY1VUuN/zB
	VAdONJ1A0zklkqI7hExJQKAI9lYfkHlJd0cXpxr6TLzEGu1mvWWwCYDdANKa8c50dhWT0lRenBb
	myVNtkoCiPaUAt08bzA+ir/tD+ohpEQwH6b4BWAybeWuCg7ItVEB/eN8Vt8+RnIGSIg==
X-Gm-Gg: AeBDiet9QuVutm+Rz9jJZrnOLdmwAiNOuQj71Ggt8sst1RBeJIgAdy4QBfmqw3e4t3Z
	PPF6ZnVZoG8Lndm9XVnufVxZAwcl3RFxfh6dxRWj1wMyWssoplPMUftVTxIATaD2RlR13vbRrf2
	TxbkuqlKCCc8Wu7Wd6jXhCDgiPSQTVHqTmg9RZkpa7meHWY5AIWRECZBZB/mgMjwwZ+NvZ3dGB6
	1atwf1NsXdsdIsyxUkrtRN6gCycS4Wl3FyiFqmxQcGsNzXBJQGZY8z8dr9qA4mOn17GAF4Y8G6P
	wXkphbwJLAwj6jiv2ScZRK9lLDk4xlZdO9ss8kY5Toosgb1i62uO90V5AXCkr4dQebBzX1hEiV9
	/pGgm19U68e1oEBC8lY42jzd1iRztICDCS8/oy1icXHGbckulpkOdPXfI
X-Received: by 2002:a05:600c:a109:b0:488:b187:3c with SMTP id 5b1f17b1804b1-488d68431ebmr127572035e9.14.1776077684047;
        Mon, 13 Apr 2026 03:54:44 -0700 (PDT)
X-Received: by 2002:a05:600c:a109:b0:488:b187:3c with SMTP id 5b1f17b1804b1-488d68431ebmr127571725e9.14.1776077683613;
        Mon, 13 Apr 2026 03:54:43 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5dbcb66sm93383495e9.9.2026.04.13.03.54.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 03:54:43 -0700 (PDT)
Message-ID: <b52ce943-18f7-4402-8b6a-3d9f69bf7d19@redhat.com>
Date: Mon, 13 Apr 2026 12:54:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 net-next 4/7] devlink: Implement devlink param multi
 attribute nested data values
To: Ratheesh Kannoth <rkannoth@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: sgoutham@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, donald.hunter@gmail.com,
 horms@kernel.org, jiri@resnulli.us, chuck.lever@oracle.com,
 matttbe@kernel.org, cjubran@nvidia.com, saeedm@nvidia.com, leon@kernel.org,
 tariqt@nvidia.com, mbloch@nvidia.com, dtatulea@nvidia.com
References: <20260409025055.1664053-1-rkannoth@marvell.com>
 <20260409025055.1664053-5-rkannoth@marvell.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260409025055.1664053-5-rkannoth@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[marvell.com,lunn.ch,davemloft.net,google.com,kernel.org,gmail.com,resnulli.us,oracle.com,nvidia.com];
	TAGGED_FROM(0.00)[bounces-278041-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D70513EB0D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/9/26 4:50 AM, Ratheesh Kannoth wrote:
> @@ -441,6 +448,7 @@ union devlink_param_value {
>  	u64 vu64;
>  	char vstr[__DEVLINK_PARAM_MAX_STRING_VALUE];
>  	bool vbool;
> +	struct devlink_param_u64_array u64arr;

You mentioned that you intend to handle the possible CONFIG_FRAME_WARN
with a separate patch. IMHO such patch need to be part of this series,
or things will stay broken for an undefined amount of time until such
patch is merged separatelly.

/P


