Return-Path: <netdev+bounces-63216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BFC82BD5D
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 10:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B67681C23B95
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 09:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B25F56B67;
	Fri, 12 Jan 2024 09:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQp9fjfk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F140551C2E
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 09:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5c65ca2e1eeso3111637a12.2
        for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 01:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705052299; x=1705657099; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E8N1kn0701JbdsAO06ctMe/2j0G/GiDgwN7ej4LX7i0=;
        b=IQp9fjfkLqCkqLj3nhbOOGlxPu5H/U9oH+Ww9q2hghnaEGficJ2EZyCl+jvvea+aFP
         fE5IfPQSQ9beuIxsv29q8vGrlqaZf8lug1jsHTbOnxw1+fphSTrCQ8qT2KybyPHiIlDP
         OLtOYps0HxzgB+t7GAlW2lcppGfL/f0VL2iS+UyX6H/U7nKevYyvcxXrg1fJB1rglxip
         X6dvoVD/0yUE7ajvRCZSkbA40A4cwWs4ikaRm7zSAvfHF+K+FDnVM6dLFCjbgcCmjsBz
         aFT3xZwpgM8fx6ihZO29kqNmfm+KcZfB+ljo4Wg1t9DoQC9JZ313ru9T4N8H9z+tjgRi
         rQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705052299; x=1705657099;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E8N1kn0701JbdsAO06ctMe/2j0G/GiDgwN7ej4LX7i0=;
        b=QCi8VLHkzNxFPdIpyjZBeHYcrRnKykafmUrTCleEdIJGxLu4OP7xNQfj9jqlFN23cO
         TyGwHUS1wPDlL8rZuQmfJkBB9SPXkmnn0iFeLLx/0eqrgXfilz4ZPt1ojpl2XsRhe5lY
         1Qf6zm00Z0SwYon2+9mFbvj7khLfUJGYGLR7vDcMCpUrTrFbmtbvhiB3OcIIV1NKxXgd
         WgNVZ9lgICpqFl7e1IPfKkDJLKncoPgAZUD+0e6NCry/SzTtRrxZjO47ggu7MI8o7N5p
         auiTgfQbkfvwWjUtBwz7gC4otcRMv2ihe2k2ObQGOv4dxHC2Edu11D7zAcsLXNGVeARa
         6vZA==
X-Gm-Message-State: AOJu0YyvyxQIR2uG2fvo7RT/RzrReTf6AGzNfT8QR0de+Mvoe2nkjjg8
	obwMqZ86PIQc8wELjG18zVo=
X-Google-Smtp-Source: AGHT+IGGjff1eoxf0pcakLL5rU+ZGGbsDRbQ1LjJn/rjR5ytxTMN10xAVWmG4i8ltYs/abHaKyZpwQ==
X-Received: by 2002:a05:6a20:2585:b0:19a:5bf4:4b2b with SMTP id k5-20020a056a20258500b0019a5bf44b2bmr581074pzd.20.1705052299257;
        Fri, 12 Jan 2024 01:38:19 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id mp13-20020a170902fd0d00b001d4ac8ac969sm2661449plb.275.2024.01.12.01.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 01:38:18 -0800 (PST)
Date: Fri, 12 Jan 2024 17:38:15 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net v4 2/2] selftests: rtnetlink: check enslaving iface
 in a bond
Message-ID: <ZaEIh5TIP6APFhEh@Laptop-X1>
References: <20240108094103.2001224-1-nicolas.dichtel@6wind.com>
 <20240108094103.2001224-3-nicolas.dichtel@6wind.com>
 <ZaCSog00Bj8GmOZ4@Laptop-X1>
 <21c2ac76-8491-4e3e-80ba-9c7e5a62a593@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <21c2ac76-8491-4e3e-80ba-9c7e5a62a593@6wind.com>

On Fri, Jan 12, 2024 at 09:06:56AM +0100, Nicolas Dichtel wrote:
> Le 12/01/2024 à 02:15, Hangbin Liu a écrit :
> [snip]
> > Hi Nicolas,
> > 
> > FYI, the selftests/net/lib.sh has been merged to net tree. Please remember
> > send a following up update to create the netns with setup_ns.
> Please be patient and don't worry.
> I said I will send an update, and thus I will send an update.

It's just a reminder. Not pushing you. Sorry if this makes you feel disturbed.

Regards
Hangbin

