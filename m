Return-Path: <netdev+bounces-177058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50227A6D885
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 11:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B7493A337C
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 10:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1BB1991C1;
	Mon, 24 Mar 2025 10:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="YxXi7PnE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADC7179BF
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 10:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742813175; cv=none; b=D4K3+ZKEBrUkx/TZMhlz/XA3Vvy6aOyrhuGTw3EZDXm/7akgJLDRC0uz+JeKc5DmM6C5NiTEWkbY3IkYbR4nseGCKOc/18djJYNPyitltQ4fC6tFDqqqXvB7Ad/2SXqEz0RIiwtRRvF9g3TwK6LYVCgrjsQrZ/FZucM3Yw8ph5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742813175; c=relaxed/simple;
	bh=t1sPJFYHRCL7g2MZycD7dr8606H5CJO5is1RkT0peyc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mm2n4sNN87D4K9IxMWlGQ/135jZ9otPGASw3OiDI6jg2NDe+yaER8niEWUTCR1g5Iz8GxG7gsZP4os0RFmsvh8llih9o2T8/+fivf6rKFunB94oAAO9YjZvS3BKwxTkmwni2goZKbQ08oMvt90oaLdRsM/FQZYJywJS5CUVwHb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=YxXi7PnE; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e5c7d6b96fso7531350a12.3
        for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 03:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1742813171; x=1743417971; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5iSTHaFjMtZz4Lo16huquawmXhb7h4576bDo6cE+odM=;
        b=YxXi7PnEsEj0RyJ90MylaoRxU2EVoVK1CtAS+pU/e419WecVLBOdk1Df8wW5npw9+k
         q13Zxl9AoIW9bHblUb23YkkUetKD+C9t7BWkpqkrTBFLJaasv3lz/pgDdIywbMmIjadk
         gRsjVjtIcOWN+BcJWLYpRVINRXO3rIno6aAYoCGJ1CamekSQ5hcKyPIcRD1cHATUihN+
         OrJGxk7zTmABq8EJ9ZQswyjui0XuX7k3NQ8IbfbWPrtfbWZtefeROExmU6jUBA4VSPhn
         hPBiuJPiwGeS9VYcQNOvyqnHXqp4HsRRHnVLesbalxvSGA+j2MeTOzPiyJAufR04R1Y8
         Tidw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742813171; x=1743417971;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5iSTHaFjMtZz4Lo16huquawmXhb7h4576bDo6cE+odM=;
        b=otuoC/N7fms3yNDSG2Y94Pyhx0ikK+QUHLxpnLzr9mNHg6K8esbKyoUHnLoeyjKuQY
         bggYiSK9SGjQTSCSYD8R6Ug/DBzZG1VkQDEBz5fUw3fGVc8+zvvvp/rFUCS8uw5QcZOD
         Pv7mwbMS4RbDJiaRMrh3OopWeKt8T3AhtN3ldy6IEOhsXX36VpxFRfE6KXLVaP0npqW4
         SWnSNHWkCFWiHsW/1LDbpZY7kfRymjfmPrW4Gc2XbqGADNQgX6uoamz7FyR/AmaNWAsS
         KRlKNyqrGH+sWdB2a0d62UCaeCch6KIjR6+88Bq00i+AGgG4xKz+hm0y9Duy1oa3Maq1
         IwuA==
X-Forwarded-Encrypted: i=1; AJvYcCUsN/+OBcprUzV0UveSDry7/RwVXpEcYQ48Z6h/Ce2U47LFo3RbrRBssHq3N7bNuzW64XKSZGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLMN0G1LXtZmEaY9pHENrNF/ANDTi7Zco3pF72R41q4CYkaga1
	KE8b7eBpJ1c9q7MaGxMSbatirkJdBJMePrA6cjjncLOQyfW/p5KNSh1DvMyqvbvU/PX3xxIuPLW
	M
X-Gm-Gg: ASbGnct/C9FNlD9OfZ9nqPXbqBHzRjU0+Ohcmi842cv2YBAdrxlSaAni5kg8vD6dTSy
	3ULfGsfVyccIYFHslZHs9gLutkEcz4BarzokmhazV7GGZ8GzdyzsnpF97JLhz7bSu6ZdeC+e34V
	IhPy1uAxeG2ZSpaF7GQChHYTwdWG7N91xtFXVrbSBFuZW/VNlDC0Zle4tDfuCtg0m20lp1Z0WJZ
	EW3m9wkT6OgU9yLE0AVWsQHPPHUS4TzVxlflFVQCgMaPt/OeBBxsJgWm8RQWps05eWfqdgsdFyb
	ScB7UOibrIbRgrdq1xRIj6jji+a5Iu3uX5h3iIxGZZcojZKBbegX6Cf6NcvVTCQhUrZV9/MqxoB
	rbdMKAkav/A==
X-Google-Smtp-Source: AGHT+IFwGrfv1Pqr2yJG5TbOopcZ32rbBAt4ukG7TRFDEd1Ffoi1/OTq4CWfN3ulzrgJE6aRIytxFw==
X-Received: by 2002:a05:6402:35cc:b0:5e5:bd8d:edb9 with SMTP id 4fb4d7f45d1cf-5ebcd433b13mr11125424a12.10.1742813170866;
        Mon, 24 Mar 2025 03:46:10 -0700 (PDT)
Received: from wkz-x13 (h-79-136-22-50.NA.cust.bahnhof.se. [79.136.22.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebccfae189sm5818889a12.37.2025.03.24.03.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 03:46:09 -0700 (PDT)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, kuba@kernel.org, maxime.chevallier@bootlin.com,
 marcin.s.wojtas@gmail.com, linux@armlinux.org.uk, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net] net: mvpp2: Prevent parser TCAM memory corruption
In-Reply-To: <1eac57a5-eae6-4e2b-99d1-2b06c8628b1e@lunn.ch>
References: <20250321090510.2914252-1-tobias@waldekranz.com>
 <3f2f66ae-b1ac-4c87-9215-c1b6949d62c4@lunn.ch>
 <87pliaa73x.fsf@waldekranz.com>
 <1eac57a5-eae6-4e2b-99d1-2b06c8628b1e@lunn.ch>
Date: Mon, 24 Mar 2025 11:46:08 +0100
Message-ID: <87msdaaeq7.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On fre, mar 21, 2025 at 14:18, Andrew Lunn <andrew@lunn.ch> wrote:
> On Fri, Mar 21, 2025 at 01:41:38PM +0100, Tobias Waldekranz wrote:
>> On fre, mar 21, 2025 at 13:12, Andrew Lunn <andrew@lunn.ch> wrote:
>> >> +static int mvpp2_prs_init_from_hw_unlocked(struct mvpp2 *priv,
>> >> +					   struct mvpp2_prs_entry *pe, int tid)
>> >>  {
>> >>  	int i;
>> >>  
>> >
>> > This is called from quite a few places, and the locking is not always
>> > obvious. Maybe add
>> 
>> Agreed, that was why i chose the _unlocked suffix vs. just prefixing
>> with _ or something. For sure I can add it, I just want to run something
>> by you first:
>> 
>> Originally, my idea was to just protect mvpp2_prs_init_from_hw() and
>> mvpp2_prs_hw_write(). Then I realized that the software shadow of the
>> SRAM table must also be protected, which is why locking had to be
>> hoisted up to the current scope.
>> 
>> > __must_hold(&priv->prs_spinlock)
>> >
>> > so sparse can verify the call paths ?
>> 
>> So if we add these asserts only to the hardware access leaf functions,
>> do we risk inadvertently signaling to future readers that the lock is
>> only there to protect the hardware tables?
>
> You can scatter __must_hold() anywhere you want, to indicate the lock
> must be held. It has no runtime overhead.
>
> And you can expand the comment where the mutex is defined to say what
> it is expected to cover.

Yes, I will definitely do that in v3.

> FYI: i've never personally used __must_hold(), but i reviewed a patch
> recently using it, which made me think it might be useful here. I
> don't know if you need additional markup, __acquires() & __releases()
> ?? You might want to deliberately break the locking and see if sparse
> reports it.

I have added __must_hold() now, but have thus far not been able to
provoke a sparse warning with it.

From what I understand __acquires()/__releases() is only needed when you
have "unbalanced" functions, to let sparse know that a function is
supposed to only either lock or unlock a particular resource - so I do
not think that is what I am missing.

If I remove the unlock from the early exit of mvpp2_prs_vid_entry_add(),
it does report the following...

drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c:1980:5: warning: context
imbalance in 'mvpp2_prs_vid_entry_add' - wrong count at exit

...which leads me to believe that the sparse's -Wcontext is active
(which is what I expected, based on the documentation in sparse(1))

I also tried removing some locking in the mt7530 driver, which also
makes use of __must_hold(), which did not trigger any sparse warnings
either.

I am not sure how to proceed. The documentation around how to use these
attributes is quite... sparse :)

