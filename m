Return-Path: <netdev+bounces-37102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6167B39FF
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 20:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id CC169282FD8
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 18:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BE46669A;
	Fri, 29 Sep 2023 18:25:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5B06667C
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 18:24:59 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9911A5
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 11:24:58 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c1ff5b741cso130441275ad.2
        for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 11:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696011897; x=1696616697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EWNSZ3YxPSHD/wio/2AsKjYLKGNLPQGZGcZxYSYqi2M=;
        b=QIALHOm9ANRQCMnMJxBP3mFzMMdWFv1aKlg7JaqJ0u9/J0WeWiOxJ7i+k1lUPYupPr
         SPhM4bm3q3fe1PW6ts0P2FibvvQ6FNwe7GpFQhujJLXWOuX7m4Mc73CjXneXxUj1eVAJ
         iJgx+P9Zk5olYkY83FbSJkwd7sWaOckO1OImg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696011897; x=1696616697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWNSZ3YxPSHD/wio/2AsKjYLKGNLPQGZGcZxYSYqi2M=;
        b=FbTsvNBElUqJzmLJ2bxFZdHQdJGeoJDRR5luYCfHkmcu20zi04bNMTS3TQMSQ0vyxv
         76Ho0NG8dcP4Nb2bPAXZmQRq+nQmSeMNVFWcNPbC2hIEYzHcaptn/6e/MJvi19/zvOBA
         tNyBDuQxPRpa51rS4AkfgbrbSVGxWeJ5C1RIEqzOMz2bWzNprufYrhC8eFeTYj69k/YB
         iRXXlNr7hZi0PsiMYOcH/A5txn6fqxIixTk3mWQjqvFG/wf8G0CybQ1X4iU4TXfvg15j
         cu3aspWl3IFGepAmHYpWh7jpLWM5QvqH7pXTXTLz6EMY0BRr5FLbq7VT9ATuaL45wfFh
         mDFg==
X-Gm-Message-State: AOJu0Yw0P1agXUGTo6vRmdbQcst0Am0wNiZLHsHBXWhhL3d3rj5mDKxb
	Hu/YNd6w0gIrixeii3iPcgpD0g==
X-Google-Smtp-Source: AGHT+IH+io+uCaRSxHZk/J1NeIEam43xU6xtIgqyJA5qlIvuBpSZvJBrUWL83IF62539ghY3HPzuQA==
X-Received: by 2002:a17:902:e746:b0:1c7:3f5f:1bc2 with SMTP id p6-20020a170902e74600b001c73f5f1bc2mr5042481plf.7.1696011897524;
        Fri, 29 Sep 2023 11:24:57 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id li11-20020a170903294b00b001c5eb37e92csm15126138plb.305.2023.09.29.11.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 11:24:57 -0700 (PDT)
Date: Fri, 29 Sep 2023 11:24:56 -0700
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jakub Kicinski <kuba@kernel.org>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] net: sched: cls_u32: Fix allocation in u32_init()
Message-ID: <202309291123.FAE665CC7@keescook>
References: <ZN5DvRyq6JNz20l1@work>
 <20230818193810.102a2581@kernel.org>
 <CAM0EoM=fZVr4ROKZ+tA9A=yxcx6LnNVFzTb+_brFv9c-CiRfdA@mail.gmail.com>
 <20230821114802.1d1ce74b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821114802.1d1ce74b@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 21, 2023 at 11:48:02AM -0700, Jakub Kicinski wrote:
> On Mon, 21 Aug 2023 10:35:29 -0400 Jamal Hadi Salim wrote:
> > > Sure, but why are you doing this? And how do you know the change is
> > > correct?
> > >
> > > There are 2 other instances where we allocate 1 entry or +1 entry.
> > > Are they not all wrong?
> > >
> > > Also some walking code seems to walk <= divisor, divisor IIUC being
> > > the array bound - 1?
> > >
> > > Jamal acked so changes are this is right, but I'd really like to
> > > understand what's going on, and I shouldn't have to ask you all
> > > these questions :S  
> > 
> > This is a "bug fix" given that the structure had no zero array
> > construct as was implied by d61491a51f7e . I didnt want to call it out
> > as a bug fix (for -net) because existing code was not harmful but
> > allocated extra memory which this patch gives back.
> > The other instances have a legit need for "flexible array".
> 
> Based on the link provided it seems like the Fixes comes in because
> someone reported compilation issues. But from the thread it seems
> like the problem only appears when sizeof_struct() is modified.
> In which case - you're right, Fixes and Reported-by tags should go.

Gustavo, can you please respin this with an updated commit log and
adjusted tags for netdev to pick up?

-- 
Kees Cook

