Return-Path: <netdev+bounces-225330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC4DB9251F
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 18:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE107188D3A6
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 16:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A30311940;
	Mon, 22 Sep 2025 16:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhbjzQH6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E0F2877DC
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 16:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758560190; cv=none; b=tWhuSpNBmVYt4zMS+ZwGFBN1OhYd0OGVq3dRZiK7LwG7x7mHT0qpRKTFeqCoR+hHW0fJ5YFFN0Phhjyqw1+66P/7VulRvMmppL9fFmKaG0J6rhFVhQDtijajKoShVAqZeXyn3GzVCPqkQcUAsSUyhkaHB6kC8Wu2PzkpBihSgVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758560190; c=relaxed/simple;
	bh=Z8aEZbk7K8wEGwngFpv4xtlpj3slvHOmmjKJQEE2J7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K403EUh+GRfxD3Fin2FXKwY1yTCPg3uGQGMSrIVZ97nb4Gj1ly/wkqKPDT2Xlb0v4o4ky52QdwvOH2mvwruuBq9xC0IwYCu2b7D+ziyuinBFXRopbsFNAWwV0DFsLu345D12xqiqPkJ+8XDTqec1DhqpPAjcghVx/zHCbMNXTF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhbjzQH6; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32326e2f0b3so3944285a91.2
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 09:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758560189; x=1759164989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nqezCH7ty2sJGRI7ApNpSX24s5g8dQOAL7yqOHAxNDg=;
        b=fhbjzQH6/2+qO4vQdhjljb7WH/Zx273MveImlkIhbAjqJ+coSeoICNPaXBy5poad6U
         x0ax81yABY2qd3h9w44qt3VwFo1/UYZ8sPoTAZw1sfHBZGTHeDRNj/n42nleN5z1I96b
         TM+l95CH9vXuN8r/vbojnYfcxtpCO9AkbMwhalCqRrInYXQE7N0KqIBICq6wfBJ7wOUB
         1F4c49nGIDegg6P0Wga+8ELID+fzaGi9yk2MIGhD/Bb/aoohjsTI4BOZd02mTNqFvEF5
         OgnO+gQW4rtHybMHWfb64cCuWApkJ0vUfytoS8XM20XuanbdqNsrG0Lqg7hNXcUnpFCz
         QEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758560189; x=1759164989;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nqezCH7ty2sJGRI7ApNpSX24s5g8dQOAL7yqOHAxNDg=;
        b=Q0MOq1FPn1rVdh1H+q1Ku1D6Kmcj6mTJdAzyHIoJ6JaoIjPhACC59RHlX8Rb5H6aLA
         dGMZ7U8/DeGhAb016zh9rF7ax5qV5FiwLOyjth/nzy/m42ZIBxPUPlK7HfORBirJ6v33
         QW6jm4NReAiH3HvVqHh/Dq/Dfy2NgwCiHHxnncnkh/CJtpxXeM33TuWp/rP3D8lJ6Frz
         4snX9MN1azBJYlEIZlIRq+h884MqVUIeaBSaoeiX86s+xn2haf5rqFTWJfgHPzdUYlEX
         Bg6Qd/4XwkMD8EQIMJwqtSb8g2HwiO74T06PBSNtgtAc5WXuIStlYv3Rm+6FRuR/D6TK
         NPcw==
X-Gm-Message-State: AOJu0Yz09xtNnxjNwuUce6Y/z1kcE0KdAfNsv+diVcPOOgkj0dcENRvj
	1ZZcsraXXDaXSlBX8jGOGj5ttsAyA5Olid5PRsAUp/xnD7ZECe/+ivez
X-Gm-Gg: ASbGncs0036Qsvayx9/wPaH0mDY1hJmXDgaIVRpn37PdfCiI9lnLo3GQvixxOSxugfX
	I1sL2voyt3aQc+8NZdzk3yNSAatWZZV7KoMeqzc1iyqgbLyOARjOhEwG+ah7FR7TijW1yjSbUyN
	1yO4GFo9DNAPdTB4nj9eDLjxSVrUM2K2DyEhno5ykzqyV/dKiLVXvvsf1YCUOL3cI+cGI1mVp0X
	FsLAYofJzr6Q4YZXSbK5xLmLoN6aTf8+XKqhJlEWc5+w5fPyOzgOr8w8xQH7y9ILJzvkIgzRU4g
	UdoLn55+d2OpMxr/IfBVnYOvorFl+JUs2TBhmO454+QHtYVBicXgYSBrge5Ag/xDu9EUEjgqiI/
	Uud4cG6QUcYxbRl9Cd/tSwhOYblQioNEt52/+O5D7IFPeKBHvm75Li9Ht+UY3mzNoPpmyAw==
X-Google-Smtp-Source: AGHT+IGz22n9GZBL59/2Ow/bMCLS/7wJcfK0mFaCKE5vjuXxwXStXHQzzY27R41ZWfk/tmc3+0XMZw==
X-Received: by 2002:a17:90b:384a:b0:332:250e:eec8 with SMTP id 98e67ed59e1d1-332250efc34mr10760767a91.15.1758560188724;
        Mon, 22 Sep 2025 09:56:28 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:9e:b61c:3ac6:b581? ([2620:10d:c090:500::6:9053])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-330606509e9sm14030816a91.9.2025.09.22.09.56.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 09:56:28 -0700 (PDT)
Message-ID: <49d3b51d-5ee0-40a6-b6c4-88f6cea96e8c@gmail.com>
Date: Mon, 22 Sep 2025 09:56:26 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] eth: fbnic: Read module EEPROM
To: Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 gustavoars@kernel.org, horms@kernel.org, jacob.e.keller@intel.com,
 kees@kernel.org, kernel-team@meta.com, lee@trager.us, linux@armlinux.org.uk,
 pabeni@redhat.com, sanman.p211993@gmail.com, suhui@nfschina.com,
 vadim.fedorenko@linux.dev
References: <20250919191624.1239810-1-mohsin.bashr@gmail.com>
 <aM-t4IBZFFHE9f-V@shredder>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <aM-t4IBZFFHE9f-V@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>> +	if (page_data->bank != 0) {
> 
> What is the reason for this check?
> 
> I understand that it's very unlikely to have a transceiver with banked
> pages connected to this NIC (requires more than 8 lanes), but it's
> generally better to not restrict this ethtool operation unless you have
> a good reason to, especially when the firmware seems to support banked
> pages.
> 
Hi Ido,

Thanks for the review.

The bank field is essentially unused in our common case. We were just 
sending bank 0 to the FW so I believe, we should be okay removing this. 
I'll update this part in V2.

>> +		NL_SET_ERR_MSG_MOD(extack,
>> +				   "Invalid bank. Only 0 is supported");
>> +		return -EINVAL;
>> +	}
>> +
>> +	fw_cmpl = __fbnic_fw_alloc_cmpl(FBNIC_TLV_MSG_ID_QSFP_READ_RESP,
> 
> QSFP is not the most accurate term, but I assume it's named that way to
> be consistent with the HW/FW data sheet.
> 

Yes, as Alex pointed out it is to be consistent with FW.

