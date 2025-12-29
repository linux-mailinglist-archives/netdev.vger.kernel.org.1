Return-Path: <netdev+bounces-246247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C555FCE7AE6
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 17:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 62B9130049FE
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 16:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F3832ED2C;
	Mon, 29 Dec 2025 16:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hXsiIOI9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YT8N6pdU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9227F222587
	for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 16:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767026851; cv=none; b=qbpWaTcMBf8E6r8LMoErfRiXWQBo/ME2+S2l74Vgl5Jh0AjRx6477B0G2fWdUC4L3HAkBVhPIos37VzD/CulPbzZ+2F12LQbm1hgzWzv9AL/mPApYbclJ97nGu8lxX7CQhJRqxJ7+2QDWkQn/D9hAKLiKsdakkxUcXHueakIU34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767026851; c=relaxed/simple;
	bh=u9+Rj2Nx5KCtNOZL1WQV63zpkR5HjS+6GcLEFPa66hU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J/crug+EVYBgpl8bb7kNxeCcIgeew4Piw1PRkvBgMsnlaM79gKRVVfSTeVu+GqGlMENMUGMe9e/n2ek4Em3+jT/zy+Hm9sTNm98sNepOrzQfsC7ZxDGDQy6ox69Y2KYMRhT/EqxUTOwCNim3+E9gYSxmdgtZGWCE6ZrV46X0sF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hXsiIOI9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YT8N6pdU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767026848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qp1WHG8KMisT3CsYd2AkOEnzIILo3AC3ffoWNbmQxcg=;
	b=hXsiIOI9eehX8bRZVQWjxU6Ck8tkC9U5IQkFUx5FKIWg/C6OnfZZOV/NJcXMz8Wez1aUPP
	54vtq3sEggRyHikEptdx2eqV592QT5yxdLOSAC/ITidYi3HpoRUoT35q4N6a2XASwItckk
	jfWpm7g2slBQGimjFekaVWz6SFIOln4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-4Si0Lx72NWqsQi5m2jin0Q-1; Mon, 29 Dec 2025 11:47:25 -0500
X-MC-Unique: 4Si0Lx72NWqsQi5m2jin0Q-1
X-Mimecast-MFC-AGG-ID: 4Si0Lx72NWqsQi5m2jin0Q_1767026844
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43009df5ab3so5130363f8f.1
        for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 08:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767026844; x=1767631644; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qp1WHG8KMisT3CsYd2AkOEnzIILo3AC3ffoWNbmQxcg=;
        b=YT8N6pdUEpUCVy71mSfLPWubQNcW8yO982hFP13k2zECFHe8Qw5222CGlmO8TPbdiq
         twcxfta/eJI4k/noDp0jstI35LSEIHizTsarcfg+h9bSaKpJXQjaRIkgtYpenttWgxgx
         w+M2Y4GfV9Nmn8y9p+qWGK+7H2ssMu3RVYdPH54Ok06zXaNmFTW5lGhy6EI9YHzWIwig
         B4eipBSBacjxMbJTBv/MjYE7+ffBxGNvNQ32b/b3jgWgu3TQISAKYnqW0sIYcWLRcibX
         +O6+xXU+EUxja9/tIgWZbocHg/CbEue3h5IKJ61jtqRnp/eOF7eUY/0LpKUQ4acPs+SF
         13qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767026844; x=1767631644;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qp1WHG8KMisT3CsYd2AkOEnzIILo3AC3ffoWNbmQxcg=;
        b=ff9PbB7VqTZeapUo8eOC4QL71CBoWikoTX9fVan/MZDF5eBgmVEM5aVBbRatAkGRLs
         l9hFuoXTBKOSr5Ilv9tERLMVomRYDidSgt44Fc8i55FhnWAyQDfLk76m6XTSXtKcMK+k
         +O3wtiakfrPU/n9+tVODlDTNDCMAXFOIPLrxbwYnsBK9KCzi1O0+WyyTSCFr3T3gb+Iw
         K2x1tovkZ+RbobYgkWvhi8KAz4ukhBWNQdFnGsTIJWPJBYLVrZKhawcPl+klILn9LVGy
         nGlmYxNsOU/zmNulW2TgPakSLkgHlACmbSTwnCmanONoV1NMTpoV0ChCg+w0KVzJuWMh
         VLHA==
X-Forwarded-Encrypted: i=1; AJvYcCXSJQQv7Vd5LLMFiEJjq4X7SpdAwK0MBHCkAlx7YZ4/m7Dce3zDm/MpHyH/5052iBeGjmMARVk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3DoDBClOyHS71wAUM+RkjkMgK3+04maj4302Vw/t00KqAESDG
	MIetC/iGSPLHueQuCL4kG6gQcG9bs6M8lbtLIE7S75pJ3+rfkwdNxKYkfNoUrOvz2KlWgbENSO0
	9TIIDhXNvoDUa431v3JQxo/mOljw8kdg5UsWvfKogezlsig0vjdx07+DFlWtymZcD4Q==
X-Gm-Gg: AY/fxX4/E9bEH40AWiDYQLVd7YNFmyY10U5kQYBrv0mK/lGfGIxIkoCU7/iSNrowuCQ
	h+dN33PMBFDwgVVyPz5FgFzGrOl2iOeDn7IRDysqP8H20iykajL0XguJA61hsYDFr6ii1jwnLpw
	5d2WFbSH/t8ZhQ8hyAlg57Zcvc2iNEDN0XCTPJbfTXHfdwbUzOR9PrITVqfI6fkkUXhIcAE0Hvd
	m2zf8RjtY6Zbg9BEIM7WMOi1N/XBqSROThZAiBS6X0esFqM4nz17B8wqJNO113j/pfE/JwafqQc
	8qtgcMqELSM8gljLxZNxmWubyg1EtJW1raU45VDloOq6somt2zytwPeHmNHRdt6beKy+sa2hxET
	T94T1WiXXtkVL5Q==
X-Received: by 2002:a05:600c:310c:b0:46e:32dd:1b1a with SMTP id 5b1f17b1804b1-47d1953b941mr283690455e9.7.1767026843782;
        Mon, 29 Dec 2025 08:47:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJ44XnxUp9khVyqx84H5Y8qUWfKy7bLqy02dEyPXjY379VL98YZVicYemqvzrk6gsc7+X8hA==
X-Received: by 2002:a05:600c:310c:b0:46e:32dd:1b1a with SMTP id 5b1f17b1804b1-47d1953b941mr283690155e9.7.1767026843363;
        Mon, 29 Dec 2025 08:47:23 -0800 (PST)
Received: from [192.168.88.32] ([169.155.232.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea227casm62923317f8f.15.2025.12.29.08.47.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Dec 2025 08:47:22 -0800 (PST)
Message-ID: <0572ccee-d6ab-4921-b44e-c8641622940f@redhat.com>
Date: Mon, 29 Dec 2025 17:47:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/3] octeon_ep: ensure dbell BADDR updation
To: Vimlesh Kumar <vimleshk@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: sedara@marvell.com, srasheed@marvell.com, hgani@marvell.com,
 Veerasenareddy Burru <vburru@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
References: <20251219100751.3063135-1-vimleshk@marvell.com>
 <20251219100751.3063135-3-vimleshk@marvell.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251219100751.3063135-3-vimleshk@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/19/25 11:07 AM, Vimlesh Kumar wrote:
> @@ -327,11 +328,13 @@ static void octep_setup_iq_regs_cnxk_pf(struct octep_device *oct, int iq_no)
>  }
>  
>  /* Setup registers for a hardware Rx Queue  */
> -static void octep_setup_oq_regs_cnxk_pf(struct octep_device *oct, int oq_no)
> +static int octep_setup_oq_regs_cnxk_pf(struct octep_device *oct, int oq_no)
>  {
>  	u64 reg_val;
>  	u64 oq_ctl = 0ULL;
> +	u64 reg_ba_val;
>  	u32 time_threshold = 0;
> +	unsigned long t_out_jiffies;
>  	struct octep_oq *oq = oct->oq[oq_no];

Ouch, the above variable declaration follows the exact opposite of the
mandated style, please use the reverse christmas tree order.

Similar nit on the next patch.

>  
>  	oq_no += CFG_GET_PORTS_PF_SRN(oct->conf);
> @@ -343,6 +346,33 @@ static void octep_setup_oq_regs_cnxk_pf(struct octep_device *oct, int oq_no)
>  			reg_val = octep_read_csr64(oct, CNXK_SDP_R_OUT_CONTROL(oq_no));
>  		} while (!(reg_val & CNXK_R_OUT_CTL_IDLE));
>  	}
> +	octep_write_csr64(oct, CNXK_SDP_R_OUT_WMARK(oq_no),  oq->max_count);
> +	/* Wait for WMARK to get applied */
> +	usleep_range(10, 15);
> +
> +	octep_write_csr64(oct, CNXK_SDP_R_OUT_SLIST_BADDR(oq_no),
> +			  oq->desc_ring_dma);
> +	octep_write_csr64(oct, CNXK_SDP_R_OUT_SLIST_RSIZE(oq_no),
> +			  oq->max_count);
> +	reg_ba_val = octep_read_csr64(oct, CNXK_SDP_R_OUT_SLIST_BADDR(oq_no));
> +
> +	if (reg_ba_val != oq->desc_ring_dma) {
> +		t_out_jiffies = jiffies + 10 * HZ;
> +		do {
> +			if (reg_ba_val == ULLONG_MAX)
> +				return -EFAULT;
> +			octep_write_csr64(oct,
> +					  CNXK_SDP_R_OUT_SLIST_BADDR(oq_no),
> +					  oq->desc_ring_dma);
> +			octep_write_csr64(oct,
> +					  CNXK_SDP_R_OUT_SLIST_RSIZE(oq_no),
> +					  oq->max_count);
> +			reg_ba_val =
> +			octep_read_csr64(oct,
> +					 CNXK_SDP_R_OUT_SLIST_BADDR(oq_no));
> +		} while ((reg_ba_val != oq->desc_ring_dma) &&
> +			  time_before(jiffies, t_out_jiffies));

If a timeout happens - !time_before(jiffies, t_out_jiffies) - execution
proceed even if reg_ba_val != oq->desc_ring_dma; I guess you should
error out istead?!? Otherwise you should at least add a comment for
future memory explaining why that is correct.

Similar question on the next patch.

/P


