Return-Path: <netdev+bounces-114300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4DC942137
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 22:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4148D28619F
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 20:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EC118CC14;
	Tue, 30 Jul 2024 20:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="HYfr7WYN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9DF18A6CE
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 20:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722369742; cv=none; b=YSkoOh/vtEl8Cjf/xNn1n4lThqTJG/mB2buMxLPpNNZpjFHZluxxPJ7uUu19DVqiDP9nFRNqU8OOSqBdKcf7oJWiDFZ46Ldp1OXzPsL3MshMFeOGduPIDaxvBJfNX/Mta1jySVVRN8Ht2TdiMIlEl748jjWCQd1fWkRX2uRW0Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722369742; c=relaxed/simple;
	bh=g3+niUA0xpO8QTVJVcFoGPOfgBAUBJotciNokbhnVRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wb1e3HHxPJ++fjL3ixjHxKDsuSr2drBk7gYbXGUYiv9ezI9pkuPeRHie9eY1cGJ1MKE4/dSFzrHuG+xdXWjLG2agA6lr+IP7JcJSrHxGuR2zCp1/JwKFCsXcF6y+GRhfL8U6M3zIot5KEi9wZmZvs1R7J6RbuAH6yvDJrzlCYPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=HYfr7WYN; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-66526e430e0so37307247b3.2
        for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 13:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722369739; x=1722974539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2gM+dZs0nyyuKls7rKhwHwLihUP2+Vq1HQ7Y/s6r/BU=;
        b=HYfr7WYNGarWyLNF69C3lXcrXW/5WVaA+PPajlEQ0z7AieDIHFfyOwQO/a7k8Fkofh
         rso4vj3PmFroT1anQVjb4V7pm09jvAv0JMJwo5DcxD8nPYDe2gmu0eaTXLJqzTUDkaxj
         voWPaWN3QVYgGAM7jG3XAkcFtnvSxBocGSwZnC/9h1a8cdyt73QRareaVtEG9jXk5/y/
         IcUBny7mNWZb4oLjnriCRSBwJvEfU5PJN67SFqyTdLgKBELgdmXdtLLe8MfInSQIRUH+
         +7TVrEwPVVscO6OA0cd595IFLAY9ov5bc8Oqi/p+UlEAg5z1gYuJRbShFrkm9XQxKpLg
         YAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722369739; x=1722974539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2gM+dZs0nyyuKls7rKhwHwLihUP2+Vq1HQ7Y/s6r/BU=;
        b=GHajmw4enSR9i20/WLFdhO/Do6iWtvPd4itIxCqn6dNyRNRhrQiSlbYvbLKg+aL7d5
         KlZwLBr1/Dke7Fk1F/seZwOPH7jgZMeDfApjGY8+uw+9haLHfvWd/E+leFj3+5Dw6Ty4
         dyqbGEW4osibWWYbA1/2SjLi5EbAXcRQSByIUh0LGutlwOZwvfOwj7d7JED/jFbAwVLP
         Zv++DyCWDzAm+E+NucpmJ+HfBwO7yVYktYxWWTiKK2N0p6r3v4IC4p6IZFRGmZ/sthvs
         m5hZ9gVaXpE8ht7ny9URaI26ZZhYHSPlr3xpjjSJFjPQlXWuJr44vYvNy1PmOy3lYNxD
         2IuA==
X-Forwarded-Encrypted: i=1; AJvYcCWxptObkB0hmxqQbw3EhTHdNQ6kRGRmaqK3GHtPOrGASAg9gz/XQdCfJqOlMsyeLs3A7kE6X30PRLyYgeodQUgR+rpy+X7q
X-Gm-Message-State: AOJu0Yz3mgGqNnBUmkhehwwDDOJfyCohLqKq6AhFUu+6xCtbr4IrP9w8
	MmLQqxXDQThpFJ2m/L5jR8VVLp0dsZZK1S6erUSr5airU2JPCg48b5o2OkGJzZY=
X-Google-Smtp-Source: AGHT+IHLhGc5P0Jkbn9GYe5+/TwFVFrZFTBX39bypM6SoAI4XaUY0Lf3nB+cU1gq/JuQtI04+biYKQ==
X-Received: by 2002:a25:d6c7:0:b0:e0b:28fa:75da with SMTP id 3f1490d57ef6-e0b54402a04mr11264617276.1.1722369739201;
        Tue, 30 Jul 2024 13:02:19 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0b2a93fa51sm2532245276.54.2024.07.30.13.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 13:02:18 -0700 (PDT)
Date: Tue, 30 Jul 2024 16:02:18 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, bpf@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>, kvm@vger.kernel.org,
	cgroups@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCHSET][RFC] struct fd and memory safety
Message-ID: <20240730200218.GC3830393@perftesting>
References: <20240730050927.GC5334@ZenIV>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730050927.GC5334@ZenIV>

On Tue, Jul 30, 2024 at 06:09:27AM +0100, Al Viro wrote:
> 		Background
> 		==========
> 

<snip>

I reviewed the best I could, validated all the error paths, checked the
resulting code.  There's a few places where you've left // style comments that I
assume you'll clean up before you are done.  I had two questions, one about
formatting and one about a changelog.  I don't think either of those are going
to affect my review if you change them, so you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to the series.  Thanks,

Josef

