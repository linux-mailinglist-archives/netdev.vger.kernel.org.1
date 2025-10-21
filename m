Return-Path: <netdev+bounces-231360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A841ABF7E2E
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 19:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5302D3AB559
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 17:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D9D34C827;
	Tue, 21 Oct 2025 17:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="dwns7217"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F24834C80D
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 17:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067365; cv=none; b=iU7U3pE+fCeCrUOmKzpzOKwrKooQshPuiOwlXI40Wvs/C5qjGERYLK+gHmTC98aCzyUYcX+W0qafLwM9H4uhH/tFsgjcHrqUkekd52ytLrQ3h6/21u1S+b1mqFMWAzhJHtk03oqwzKjojBUIDD+bAB+gPfhvgPzbt6xQkpiP2CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067365; c=relaxed/simple;
	bh=G8mckoPFLCNDgpMeg8QaG3P4bXNzis3qzI61jgMIn3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uGwF8fR99ii9ZsFPUXa2BKWe9fzK1iEK20zkC1jCYOp7Yd6h+9WWom7jchzl9svxJvKfNY+9HO5hOp5hsQpSnfI1m1SD45ogMTElCKYRR9S7MXaKWT8FB9UV+J8ZIR7DiiHU4FUA30KwQ0xE/Qiz4Q0M304O8JxDcPvE1RT6VY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=dwns7217; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b463f986f80so1133947466b.2
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 10:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1761067362; x=1761672162; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ggMBBGHDCUPAPA7jaGoEjRt0T/w2dBdmGMiBRgHX+Ao=;
        b=dwns7217ZllBq60mpwsbdVESfA81h/ZyVyfyoqI4Epw3T+urp8ghJpnprHiwulIGx/
         3zCIkKsdYPOdSCuscDhUjsdHOh7xKTN4H1q8x9HVjr5pkMBJL79qbI2O+SCltjMu7M7J
         avgBgZmk73AKRujtOZcUm+0ooLJM6l+hNlK7uEO77AwTaeirQ0nb2PQyRgNqk8KNa3XA
         DwENZw1K7xFvdDo3HFEkvQi8ISuBI/cpy997AXW3UlPLabyux+amjhRwJeSbeJ2G/Ftj
         zi3+u0EFEC9UCVEYuCzttJ6pDbocCR4zyssfAUy9SpdmEAxIEu5PpoZS9zy/cGpTm85y
         7G6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761067362; x=1761672162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ggMBBGHDCUPAPA7jaGoEjRt0T/w2dBdmGMiBRgHX+Ao=;
        b=hAbaebgw5dS4ud8OvsFvL8Ob0tWfe8+JM1eDhmE4+RpOYO1CYLkSfemi+kIMkUZKZX
         QDr2J6yNAge7BP00U3jgo+4b18RlvhfmeNpaItIJhq8qlDoMs+ckCoKwDwcgVPgd1i+C
         kSbXHHM8w+tCrCohquiRNqCLR5EiTRFJOJbmlqtGdAGx6TETx7uF7UVebyJifEWoGKV5
         TtgQmkYcP8ZL/R7Scf3NPBUTWvnrx5D63sQFCjmXd3JqCgTLIO6RjJoKbqBJN3D4xSaJ
         NkRWO8t2QKThr0DSqodK1oCNZaiIQDA6wdEdgIeCPtKUu6yYO7OZeI1nJC3XJQiEK73P
         vRdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOY48lhvLoi1UhZ7/PM1lWmbAkZDucvlKACF/nBOmhFhYfi7bR3o4xiVyRSxqsyYFX7f/bhqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCadzbqn4DB89qOmq5XPKY9gHZ5QDTleSLTXlAvFsIdBPdMEdP
	x2giRb7cNqaTiKatKncjH4dx7vNgC2J0pIodJY1wO/7RdQHDJKGbgpYJ
X-Gm-Gg: ASbGncv5L4YvhgXl1aaNMtufMhN1l9cmKM47mnmISRy91eh0yH2f5AHBZwPzdA2LMAq
	YjmC1WuX4pnklXA4VnWL+7GMgoLdSue7W3GARFBrC/dmTi0wIoYe+weOqdYbbOUbF7Ouo35YBnk
	nfdDJrVTHWU2QkIT3Ev94P/qK+AM/R+VtKzTQzcajgR2ndXpFwhn+KDy/Ud5XKAkvOiH/tBJVCs
	s5oFct6JCw38SuEgr2pDeLLYbREBuIfGJI4jFoVEJmLCWQhpRkdoYdYLa0UtrnuJhSn5GcX+ZnM
	Xi4FE3UhatgqcUzuB2sE4DeOpkz1C3WUtYBW/11/BojZUKKKma8QMt+Gcu1QPIj/+AiTvHKRYrc
	BUHH/5yqyRiGs31px5GfcZ++ln38fEevdwdMGLevZZQSWDMjFF9xr1KrVsTfIf+VXHQXTItn8
X-Google-Smtp-Source: AGHT+IFKDcEQuPW4d2ec2CWbLMx6Bu0HCyBun2U/xIz22mZABHYUTeWloU/S+k55rMWly/ntSoWVUA==
X-Received: by 2002:a17:907:9303:b0:b2b:3481:93c8 with SMTP id a640c23a62f3a-b647304ae3fmr1874648266b.19.1761067361568;
        Tue, 21 Oct 2025 10:22:41 -0700 (PDT)
Received: from hp-kozhuh ([2a01:5a8:304:48d5::100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e8395c52sm1117491766b.30.2025.10.21.10.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 10:22:39 -0700 (PDT)
Sender: Zahari Doychev <zahari.doychev@googlemail.com>
Date: Tue, 21 Oct 2025 20:21:32 +0300
From: Zahari Doychev <zahari.doychev@linux.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: donald.hunter@gmail.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, jacob.e.keller@intel.com, ast@fiberby.net, 
	matttbe@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	johannes@sipsolutions.net
Subject: Re: [PATCH 1/4] ynl: samples: add tc filter add example
Message-ID: <uq7r3zj5ys62leti7mynsg667dexwewscdyuhfnabowx7xeaig@xc2dw2uxfcah>
References: <20251018151737.365485-1-zahari.doychev@linux.com>
 <20251018151737.365485-2-zahari.doychev@linux.com>
 <20251020162020.476b9a78@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020162020.476b9a78@kernel.org>

On Mon, Oct 20, 2025 at 04:20:20PM -0700, Jakub Kicinski wrote:
> On Sat, 18 Oct 2025 17:17:34 +0200 Zahari Doychev wrote:
> > Add a simple tool that demonstrates adding a flower filter with two
> > VLAN push actions. This example can be invoked as:
> 
> Could you also do a dump and then delete? Make the sample work as a
> quasi-selftest for YNL? Take a look at the rt-link sample for instance.
> 

sure, I will do that and send an update.

