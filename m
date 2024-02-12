Return-Path: <netdev+bounces-71022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B27851A41
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 17:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 567251C2103F
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 16:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321C03D54D;
	Mon, 12 Feb 2024 16:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="G+C7fosW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C5348781
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 16:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707756843; cv=none; b=cBg0OnCFtHrOkgCsaecUXAnvICLl6XZ4BHmUhwooeL4z+XCAF/Gs3KnQgIhJJKRmfrb5ULWnG3TtICud4VWHKew7kIeVI4Ibp4kGZ5o4dWhOicrwK5AACmwa4uF70N3+eYKnBKGPikZ/JqY3JdNofh00ivz0bT7KvAiuQ8M6/S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707756843; c=relaxed/simple;
	bh=alxSs5UvkY8imXVxVZX+LZ8+SaTJTpHiEN7+eW5p+Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HXUy1F8Wgj32SdihLnUQfkDxqvBGU+OCYYzdcpVhItwNXQG65Ah3E5CZCZ5EZ/SIBmVfC7+YaD2IlCPXqHTFkFbJy02EXj8REtK7QjTkNXdNJqafq3YoJ29sL+3OJ2G8BVDKzgDCp/lHnfXV0ESUVvPHxlhZUVbfrpX3Mqr2IJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=G+C7fosW; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d911c2103aso15536295ad.0
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 08:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1707756840; x=1708361640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qibSo3QeSC5ayPpdKXxUDsHmfCvcyduGcd6A1t8TJWc=;
        b=G+C7fosWPxpLjjrVjNTvtKa44J+eZwStmgfHjswPVOBWGaZJZ+JyGAHHlTI61zbvLC
         o/VDuUu9pGRDKz7PrabGGjZ0ugzMQVWdVMNQJwq1ZTRjBzbqn/M0RD81mC6bkYWyVuDL
         S4GUMfFJb8MP7EHn24hoMtFd0Z7Mod5/h6kJxY3BiCx8pL5o10izYdtLnlEHSRcVpqGW
         EiDJgVJYpDwYNVrznklH8Rr6ld6yJ2zbv4SMYwQAOoSjn0vhhdTNBUu4LZJf0kGX0/Uk
         UKKli/BtgE4f95ofR0auM67XrQrsw5a8xHyYE3yoYWsQuH404RAj7f9bxzVHjrBzp3kr
         VjEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707756840; x=1708361640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qibSo3QeSC5ayPpdKXxUDsHmfCvcyduGcd6A1t8TJWc=;
        b=q8/AG9j7SFRYul/X4XBFQamM47+5jF2eN7MHP/dHC3YG/M1omdC+QJauJ37Oecb87a
         0jlpj8KspRHxGc5PW3sY8c6aU7JBRvbI8RnF1kruYC3rpPMu5Ac3bqyqYP6rz9lYhT9F
         sEI0yqyZqVIZSu7grZ2IkUYPx2B6KCJ8X8SJMijwovY1F3L+JWKrheyFZVbuGu4Q4cPw
         dJoeCowrC5FSuGd0oNfHIJ8ehdM+ZaGLvpcFl0aHadB7GQWJNTY5plLkonjNkJId5Art
         5AkAjHiMKTjGQuDpx/tB+90ixuH6TyZtFcyycBANgtLphpt8ui7K58aaCVuJ3BOcENzj
         kYxg==
X-Gm-Message-State: AOJu0YyTVmkLrdjjB+RW5bmZ+lPEu/XZkpUncw1k0byoWlJs6+N+s84+
	ZitcVSGp2JrdZ3eiwD/LfGQKCJMAIXYgHAVIKUg/vfFvjUGxs2PmppxL2/H1eCQ=
X-Google-Smtp-Source: AGHT+IFAZZAv9oL5LxkFpm0LVBnxF6tsBw2l9wT8EhtWLJan1N+MKXVIOfyKZJOgQTeqOPbsYY7WBw==
X-Received: by 2002:a17:902:680a:b0:1d9:3843:3f07 with SMTP id h10-20020a170902680a00b001d938433f07mr5828051plk.61.1707756840491;
        Mon, 12 Feb 2024 08:54:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUWKTGmNXyNSYpRvMgggAEI2JGJFPfFds8URafyiaABu9B06CNEXh2/fZKZmi+QepsgTsbai8lHHGeXGNKxCkzO
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id 2-20020a170902c10200b001d94644382dsm573118pli.108.2024.02.12.08.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 08:54:00 -0800 (PST)
Date: Mon, 12 Feb 2024 08:53:58 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com
Subject: Re: [PATCH iproute2] tc: u32: check return value from snprintf
Message-ID: <20240212085358.22be1db6@hermes.local>
In-Reply-To: <ZcnHwRCr6s3T8VXt@Laptop-X1>
References: <20240211010441.8262-1-stephen@networkplumber.org>
	<ZcnHwRCr6s3T8VXt@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Feb 2024 15:24:49 +0800
Hangbin Liu <liuhangbin@gmail.com> wrote:

> On Sat, Feb 10, 2024 at 05:04:23PM -0800, Stephen Hemminger wrote:
> > Add assertion to check for case of snprintf failing (bad format?)
> > or buffer getting full.
> > 
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>  
> 
> Hi Stephen,
> 
> Is there a bug report or something else that we only do the assertion
> for tc/f_u32.c?
> 
> Thanks
> Hangbin

No bug, it is not possible to trigger with current code.
Return of < 0 only happens with improper format string,
and the overrun would only happen if buffer was not big enough
The bsize is SPRINT_BUF() which is 64 bytes.

It is more a way to avoid some code checker complaining in future.

