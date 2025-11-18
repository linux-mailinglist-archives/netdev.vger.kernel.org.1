Return-Path: <netdev+bounces-239508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 499F0C68FB8
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 12:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B40A14E4276
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 11:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712513126AD;
	Tue, 18 Nov 2025 11:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iCmD/BFk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="goLivETk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870B4314B6D
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 11:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763464033; cv=none; b=czSdlWr+GHT+lGYdVP7qJgV+pgKyZNZ0TZkms8YTHE2zQjxZVB2qQVl26+1aiO02xEDo9onOMpxjYcBXHtRXfOy60HSkHG7LBHakpQmqXzSTS+JbdkNbeYXwuum46YvZa8ckamYzJ66Bd6ZxF1PcWAq/xBE0JEXbuihAuJYQl9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763464033; c=relaxed/simple;
	bh=uRWZEQBY4jRXT69UaMHqjSwl3Z//jjtrdedVKtQb790=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DAl7pzS+8VTd7dGO1lIajFBPNR7tXPFwyCFKBEB8wAbEEQm5Icq4Xq4opA606BlltL9IZdiJ2QDCU6vfkFdz1BaOmTMFOENfdHd2AZs48Y1ILdyenQNrr9+8wSYntwYpnxCxH3Ya14uoqslcc/BxAAFFzrrVGQCWWiB79/HLNCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iCmD/BFk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=goLivETk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763464030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NOBGLy46090TiGFv5WeCbtcvOC8aqE7xeqyV3l1EZmk=;
	b=iCmD/BFkBr0XcdecSrbLimei97q83+rs04j6JU1oMUjZkD64JV2W95qnhEPprMRRcy+jY4
	s79qe7OqP1LdA2WvvclMrpJLVuq4xYTwC/TbaN81BfJjPO23uClmfhit9whwt1ka8Qi/Tk
	2fYF+QwdzuAwZH2AXiZMDKhbVK6K9kc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-kkNkbem5OrWXPIutMXx3Vg-1; Tue, 18 Nov 2025 06:07:09 -0500
X-MC-Unique: kkNkbem5OrWXPIutMXx3Vg-1
X-Mimecast-MFC-AGG-ID: kkNkbem5OrWXPIutMXx3Vg_1763464028
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477563e531cso44875925e9.1
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 03:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763464028; x=1764068828; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NOBGLy46090TiGFv5WeCbtcvOC8aqE7xeqyV3l1EZmk=;
        b=goLivETkezVMGWFJTvJPPu+ZDGEsDI7PXfqCRrEZp/1Bdu/9n4/v4dyH0uGB4aJcSn
         ytO8u/rNzbUkyo5ILOwjSvw2JxelGuLPJ1nE2BXP1WShY46sPO0obSdcHBiVD1qAhTR4
         59vAKXfJS9P52KZYY3OX1H47+1RQjm/kgTn1ZshUOLbZKqoc03IxIYRqvcnl3WrLjNLT
         eds9Oh9ZubIpi240DVNMGbhftdbtSqcjA6Qi7Jcjrt/6/TzjinqJ5cFfLx7pNBwIeWTJ
         n+RbPjqzvujZKNQYV36PF+vDDpeus2VSWf1Bp1oSb+HzXBiHl67qiv+SnW7wIeXRzBRb
         5Ejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763464028; x=1764068828;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NOBGLy46090TiGFv5WeCbtcvOC8aqE7xeqyV3l1EZmk=;
        b=Lb2G1XvwSdUnhM7AOfJLaFVKphv/Wcr4wY9d6MkNSDiF6S5npNf0iHb6oNdb+S9n8h
         8LJabVoTicezX0Kt0gfcTPKzcHXEY72MCHAGoudzDsV0LX93xcAZE27DJXPz2w67J43U
         uycLvL8moyuI+cMqcHln4ufDOfDDpwZglT5KChPFw+QgKe4u059Baxnl7as2XjQhxl/K
         YR9vDnBer/vJP0puMTCCP7Sq//qlrcHVGscH31WLbxkr3rYIeed3moYAwLop8N3Uv/zM
         7/z5hj/4//8S4cUQcmwQfHG464lhwqZW/8E3iQldViSiWxugl1rcu9ckAwP0JH6aCES7
         u7Ow==
X-Forwarded-Encrypted: i=1; AJvYcCUtGfwzZY07C9nx3AMqxtkIuTi1HC5Lm/RtWK32sClIBwG49obWWcY0uoQAZ0t7j2nexMC/f0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjP0KWOXATM+M4XqimCQfNfc20wfHiw9bVUT/yT8aGQHJrlUjF
	4Uep6CVrjLAAdQOI7cvFM4xrC3ty1rKUzmjBmS/uzUDlt+Pjycd6CvmdI6k/2CnD2iMBRklbEuB
	VHv1wn54G6hf/v2xuuGAGLzyajORuR5yKD95RquCUnyhbDJNWke1LYSGr6g==
X-Gm-Gg: ASbGncv2g52juLEijXrQ9BK/sTOxhujFGOzmsUEQ7aa1Ot7nJ+Vo0gTVbL5ivM1ca1j
	W+ufnqGdQ+qEp4fooqUVDp8NMAMCBQGfhcKuRKkpOHj42hl2kN3SEXEYDpD5bJ5kyfKk/IfxGgX
	kNsWJ26vUGfHWelmTUSe2C/rh3iPc500N/0Z60XwumLLPZgr9iAOWjHseV0Q+ZKaXcQ/rkMM8Du
	G0YD/s211CcGB1rAd8zdFZEafKYmhYPyACHjpf4jqKj9lwqIlVOIeavkvRg7/vQrnnya31kPrBU
	Q1fVCNGhzIgFxONKkjOqzdpuZXdfbZlVbJiV/CF2gHme0ki4nR43opc5K1wKRB7OSqz5zfmNKqY
	afFeeJ9Nw3V32
X-Received: by 2002:a05:600c:81e:b0:477:97c7:9be7 with SMTP id 5b1f17b1804b1-47797c79dc4mr67171355e9.1.1763464027897;
        Tue, 18 Nov 2025 03:07:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE32I37jdreSylYZB8qbdmakFIWmjN36IWLeXp3Bysm0+PSvZWyhfde1dxUtuijEXKkoKQioQ==
X-Received: by 2002:a05:600c:81e:b0:477:97c7:9be7 with SMTP id 5b1f17b1804b1-47797c79dc4mr67171155e9.1.1763464027539;
        Tue, 18 Nov 2025 03:07:07 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7ae16sm31788181f8f.3.2025.11.18.03.07.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 03:07:07 -0800 (PST)
Message-ID: <2e11014d-2782-4533-91a4-ff952077f042@redhat.com>
Date: Tue, 18 Nov 2025 12:07:06 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v4 07/10] fbnic: Add logic to track PMD state via
 MAC/PCS signals
To: Alexander Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net
References: <176305128544.3573217.7529629511881918177.stgit@ahduyck-xeon-server.home.arpa>
 <176305162259.3573217.16863263438601087321.stgit@ahduyck-xeon-server.home.arpa>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <176305162259.3573217.16863263438601087321.stgit@ahduyck-xeon-server.home.arpa>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/13/25 5:33 PM, Alexander Duyck wrote:
> +/**
> + * fbnic_phylink_pmd_training_complete_notify - PMD training complete notifier
> + * @netdev: Netdev struct phylink device attached to
> + *
> + * When the link first comes up the PMD will have a period of 2 to 3 seconds
> + * where the link will flutter due to link training. To avoid spamming the
> + * kernel log with messages about this we add a delay of 4 seconds from the
> + * time of the last PCS report of link so that we can guarantee we are unlikely
> + * to see any further link loss events due to link training.
> + **/
> +void fbnic_phylink_pmd_training_complete_notify(struct net_device *netdev)
> +{
> +	struct fbnic_net *fbn = netdev_priv(netdev);
> +	struct fbnic_dev *fbd = fbn->fbd;
> +
> +	if (fbd->pmd_state != FBNIC_PMD_TRAINING)
> +		return;
> +
> +	if (!time_before(fbd->end_of_pmd_training, jiffies))
> +		return;
> +
> +	fbd->pmd_state = FBNIC_PMD_SEND_DATA;
> +
> +	phylink_pcs_change(&fbn->phylink_pcs, false);

AFAICS the above runs with no lock and can race with
pcs_get_state()/fbnic_pmd_update_state(). Is there some logic safeguard
logic I'm missing? Why 'pmd_state' does not need ONCE annotation?

Thanks,

Paolo


