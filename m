Return-Path: <netdev+bounces-37420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7A57B545C
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 15:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 2C01F1C20754
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 13:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93CD199D7;
	Mon,  2 Oct 2023 13:54:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9FA199D5
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 13:54:46 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4A5B0
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 06:54:45 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id af79cd13be357-77574c076e4so479585085a.1
        for <netdev@vger.kernel.org>; Mon, 02 Oct 2023 06:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1696254885; x=1696859685; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=STxM7vkkmDyUmxUH+gQAbgTWzPPiXJaAVUcK/e9j1i4=;
        b=p+RYV19piPjRHM9Mw2x+fMFRK2I+NmPpr1O9Q+lYe3ltFSAzJHE047s1Mc9RnZAqXo
         C/3j9l1hyswjG7aXScr28pmn6xP9drhjD8Fo9MxlRCaZ597elhzK+cgOLYWLzvAg5ozy
         LwkyozfzAfWlWIaP2QzZioPHnPc9pg345mr33Fv/voFV8h12oiSSKcxX9dq1Z22TqgLC
         vRa+QYKkzeCFbR97RxPvKQzNASwUhQODtmUOtlF9OqSEgIH6Tcfz+3eRr3gN20GLOK3E
         9dRTnOW+8u/G4fPO3O+kSolj5MPcgzOzCoezhgaxVYJcbn4vk90Yb8rvIzYUX8fDziek
         zgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696254885; x=1696859685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=STxM7vkkmDyUmxUH+gQAbgTWzPPiXJaAVUcK/e9j1i4=;
        b=XoqcedYTHplyETqDKkZBuVq3HPLHNVGI3wv54xOw5WDcjYB9anYTpO06p9GK4akFZN
         2gzZYcK0PtX4PPJ7hKu/GjfZVWXsDBMcbxjQ7axSiPAbrp0/0RlwppLbCh8ecgG8F7W/
         Fp4Umf9UBVpLIXm+6TKIFG9VaCGtuuTXzHCutMZz5sYo9naFVpx7amnGxA8x4oF+VXtV
         N7baCP7zJxF7BiidRnIcZJeRzZ1GkEpH5Qsyg1asyrSBFyUmR1CoFEpfXulKNl1NTIF/
         L+MAssCwGzt70TIZrGi9qYEvo+zblcIpI46/fTgsKzTmo5pOlHlcFfvkv9iOdoUIlpAf
         ZSXQ==
X-Gm-Message-State: AOJu0Yxa/DDnvpEqoXEwmpfODlmJy/mWKJFlYL0rkeXkcicD/NDGTuaW
	lt+BVxsuEGvxYIaw/RfR3nHC3A==
X-Google-Smtp-Source: AGHT+IEs4NNprUgXOj7mVjG0S6MI/X0bgLI21KGJ4S6Xc/WbrCRFCrApaXSxBK8zWzz0pDpmlfRmAA==
X-Received: by 2002:a05:620a:12f1:b0:774:13e:71cd with SMTP id f17-20020a05620a12f100b00774013e71cdmr10622494qkl.56.1696254884697;
        Mon, 02 Oct 2023 06:54:44 -0700 (PDT)
Received: from dell-precision-5540 ([50.212.55.89])
        by smtp.gmail.com with ESMTPSA id h8-20020ae9ec08000000b0076e672f535asm8922296qkg.57.2023.10.02.06.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 06:54:44 -0700 (PDT)
Date: Mon, 2 Oct 2023 09:54:34 -0400
From: Ben Wolsieffer <ben.wolsieffer@hefring.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Christophe Roullier <christophe.roullier@st.com>
Subject: Re: [PATCH net] net: stmmac: dwmac-stm32: fix resume on STM32 MCU
Message-ID: <ZRrLmjxoIIx7pIcs@dell-precision-5540>
References: <20230927175749.1419774-1-ben.wolsieffer@hefring.com>
 <681cc4ca-9fd7-9436-6c7d-d7da95026ce3@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <681cc4ca-9fd7-9436-6c7d-d7da95026ce3@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Jacob,

On Fri, Sep 29, 2023 at 10:48:47AM -0700, Jacob Keller wrote:
> 
> 
> On 9/27/2023 10:57 AM, Ben Wolsieffer wrote:
> > The STM32MP1 keeps clk_rx enabled during suspend, and therefore the
> > driver does not enable the clock in stm32_dwmac_init() if the device was
> > suspended. The problem is that this same code runs on STM32 MCUs, which
> > do disable clk_rx during suspend, causing the clock to never be
> > re-enabled on resume.
> > 
> > This patch adds a variant flag to indicate that clk_rx remains enabled
> > during suspend, and uses this to decide whether to enable the clock in
> > stm32_dwmac_init() if the device was suspended.
> > 
> 
> Why not just keep clk_rx enabled unconditionally or unconditionally stop
> it during suspend? I guess that might be part of a larger cleanup and
> has more side effects?

Ideally, you want to turn off as many clocks as possible in suspend to
save power. I'm assuming there is some hardware reason the STM32MP1
needs the RX clock on during suspend, but it was not explained in the
original patch. Without more information, I'm trying to maintain the
existing behavior.

> 
> > This approach fixes this specific bug with limited opportunity for
> > unintended side-effects, but I have a follow up patch that will refactor
> > the clock configuration and hopefully make it less error prone.
> > 
> 
> I'd guess the follow-up refactor would target next?
> 
> > Fixes: 6528e02cc9ff ("net: ethernet: stmmac: add adaptation for stm32mp157c.")
> > Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
> > ---
> 
> This seems pretty small and targeted so it does make sense to me as a
> net fix, but it definitely feels like a workaround.
> 
> I look forward to reading the cleanup patch mentioned.

Sorry, I should have linked this when I re-posted this patch for
net, but I previously submitted this patch as part of a series with
the cleanup but was asked to split them up for net and net-next.
Personally, I would be fine with them going into net-next together (or
squashed).

The original series can be found here:
https://lore.kernel.org/linux-arm-kernel/20230919164535.128125-3-ben.wolsieffer@hefring.com/T/

Thanks, Ben

