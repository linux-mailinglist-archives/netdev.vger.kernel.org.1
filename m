Return-Path: <netdev+bounces-189933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F01B5AB48B2
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 03:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E4957A3A09
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 01:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA68B1547F2;
	Tue, 13 May 2025 01:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bw6sGfTD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395D3383
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 01:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747098894; cv=none; b=rn/pxIblnoGlS+agPHtLe1HHIK+MFzB0ZRR3BqJYw3YoSk+wlvauCOSmbF+0Wru1X+2CgHhKtEad6MGZW4skMCrQXpyDCUSCEFLTTnnS07HmDqTMmNXO/bGRboQxl2ZSH8i4rg28pIbk9PyHvjvy7DU0rKHNuhioPkJ+7DFF3r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747098894; c=relaxed/simple;
	bh=bpISK51u0dHJcMuCXAT6qyx9t0Fyx3UXkwIn4mcRoC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcaeOL7lqTaEFyNtK+4HCdgsHUITPhxDLWxTrCVaX+1pODmjK0Mz9f9VeVLBomhKcQxFgN4UNvVXM2YT/1mL2KabvcuPkPAkEKv3zDLIddWqqeyVMZdKnzO/AdT2aCQabOrF2tL0XGt6YZwLYy10IEUUg9TMypUOJGJOEA75Oc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bw6sGfTD; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7418e182864so4005326b3a.1
        for <netdev@vger.kernel.org>; Mon, 12 May 2025 18:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747098892; x=1747703692; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ObWyMp2XqW/8laLhN26oqnGLSG9Ev4hf3VHDw0JsKhY=;
        b=Bw6sGfTDqrnFohqhcd3fddQeNg7pk0q+Pp2x6sYVa+j758ilOEV61xDWStV7zn02Tm
         UlyKfNjOyLQ1QwN/a+2Ps7JrWTLD1HDlzr+LWE8jQbQlZLDCmEXO/iP0BYxguVsiVcEi
         m/6cHRdPEYLWQW+l5C/uOSS8lnKjz9CKD5pe/gNFwL50KQBGLoG9C+8txr8oL/I4fiKH
         Uwps7lDnzhtOCv5waNhikGtn6LjU0wmhZb8CJ9HtU7BeMLj+ZrEKt26qkexDHvYg1CBU
         e3XZUBBpcWZFa38v+6Teqw4JR0iF92MBcfixvvj+48fGDgaRiE9w9T1fouCAybuUhAJq
         2Ggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747098892; x=1747703692;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ObWyMp2XqW/8laLhN26oqnGLSG9Ev4hf3VHDw0JsKhY=;
        b=a5ZvlCPmYcdQl2nOcapshyeRNFkAxiqjI2mS5h9RGnKO4fAZrI/T1rCV/bL+4RQGZy
         P4yuK3gRSMGv3Z/2/drvF/ffrKWc7xk6NW4ekATZhVpsE215KoQ69VLb2mK4L1Jr2u0F
         /4BeBGrJZNPWZBvZnh1cf9YDsp158yYCu4oB5/xT1cl7mcq+kzY+xxi7QNbWE0qKHHo0
         pqSWuD0Zb3lXzz8Rbg+wlj5p9uunGsE5K86Jw7PwxgSGlPQyH8MGm2ArQshzkSxX3EgL
         IGp0dsM35FPzcghuq2FOmbmQtP17VTb89Olsjjx9rzd/esLOgiN4Fh4ulFmBRHQYfK58
         2RiA==
X-Forwarded-Encrypted: i=1; AJvYcCUG3QfAP0J3pbQ8NyxshtqkPSYT1jPsWEtiMGJP2dpJLDs7BJ0I5WznJPOallBNC2d7CL+VsMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzERAINVYanpHWzFAya7HcS6KJhBtDp/ykmycx4/Vqe84DWdKo8
	6K7+5GgI++p7gXsAR2aj9lfcRayOqRO0jWSVoT07+XonWpqZi7A=
X-Gm-Gg: ASbGncskz8xqe4+ISzzLwHzCpPu5L34JHtcnMiQSzmPgYWyTRFYcJrDlbY/iMXKN+6C
	Q3LnYHq3FsehRD+Nn21U24BYuq/3U1PJPqhRK2Y8po70i0mpg0m+u+y6f4Ib3Hek6HSWaJFFKBt
	GkgDXyBjrsdW3Vn5R8bdOfb4369zcFzjuyFeKv6Bqs1XPlDQmzPWC9kkp6biFl/Zk5MaFKdWSF0
	dEJu+H337ul2ly/WFMZERprVGYgCdLcDVkY0wfPPWIDtQxsFmg/xCwii/fHrn37jJDdvRiZa4tQ
	XYh5FjIzFm8LlApJ6zvnrdLszXydqfE3nT+Z4DLgSKx1lcUvZusqXYCr+ovrgA2J1Wb2IOsgBRT
	+d7fIuuzUINth
X-Google-Smtp-Source: AGHT+IHEmkGbi+VVUjjQhAyvkJGupx2XCspCKILwZNJgovwfx8PP6850pA2ZKJGOdnBZfoE+SW+oEQ==
X-Received: by 2002:a05:6a00:1488:b0:736:34ca:dee2 with SMTP id d2e1a72fcca58-7423ba81707mr22000346b3a.4.1747098892384;
        Mon, 12 May 2025 18:14:52 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74237a104e7sm6837393b3a.104.2025.05.12.18.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 18:14:51 -0700 (PDT)
Date: Mon, 12 May 2025 18:14:51 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com, sdf@fomichev.me,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH net] bnxt_en: bring back rtnl_lock() in
 bnxt_fw_reset_task()
Message-ID: <aCKdCwjxSLcfw27k@mini-arch>
References: <20250512063755.2649126-1-michael.chan@broadcom.com>
 <aCIDvir-w1qBQo3m@mini-arch>
 <CACKFLikQtZ6c50q44Un-jQM4G2mvMf31Qp0+fRFUbNF9p9NJ_A@mail.gmail.com>
 <aCKHkBnPmVwmpsh2@mini-arch>
 <20250512172649.31800d90@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250512172649.31800d90@kernel.org>

On 05/12, Jakub Kicinski wrote:
> On Mon, 12 May 2025 16:43:12 -0700 Stanislav Fomichev wrote:
> > On 05/12, Michael Chan wrote:
> > > On Mon, May 12, 2025 at 7:20 AM Stanislav Fomichev <stfomichev@gmail.com> wrote:  
> > > > Will the following work instead? netdev_ops_assert_locked should take
> > > > care of asserting either ops lock or rtnl lock depending on the device
> > > > properties.  
> > > 
> > > It works for netif_set_real_num_tx_queues() but I also need to replace
> > > the ASSERT_RTNL() with netdev_ops_assert_locked(dev) in
> > > __udp_tunnel_nic_reset_ntf().  
> > 
> > Sounds good!
> 
> Mm... To me it sounds concerning. UDP tunnel port tracking doesn't have
> any locks, it depends on RTNL. Are y'all sure we can just drop the
> ASSERT_RTNL() and nothing will blow up? Or did I misunderstand?
> 
> I'd go with Michael's patch for net and revisit in net-next if you're
> filling bold.

Good point. But in this case, we need to cover more? bnxt_open from
bnxt_resume and the callers of bnxt_reset?

