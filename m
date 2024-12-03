Return-Path: <netdev+bounces-148313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D43BB9E117B
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 03:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A3A9283415
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 02:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5C3137C35;
	Tue,  3 Dec 2024 02:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/WZcLIs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB58E17555
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 02:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733194293; cv=none; b=sokxH+tgSBvm15b1Qb/D8xHlxSQgeRsj8FyTaMalkqpTqPrdxdHiMBJhBkJMp+6VLg+JFFxsZ5m61vmDX4BSiJ3duit389dXQmhexIla+n6S3+znfl68xOE1xR9GlY5cOA9CBqVMnDlaxD5Hdlchk1h/Gzf72zoic/6+y2Y+ZEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733194293; c=relaxed/simple;
	bh=vbgyQ03+F6RIwTN0rVhjgurSNi1zMIVch0imO7bXY78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DXyZ0lhxK4RnQW23c01DswqoBF2rNsNYvW4wuaf4+86Fc2+b4xjRQQ+1jrqbwP1wGzWSPc7D3HZfK0BZyx1wEzYr0KDWEL5hzY7JL0CiKCaKpyc+L/xsmVQUdK/PhvEEL5qzgKXAw2s5erwNRppgLLXxPKrJWIklzZm0ErwP8II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/WZcLIs; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-385dbf79881so2397666f8f.1
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 18:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733194290; x=1733799090; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vbgyQ03+F6RIwTN0rVhjgurSNi1zMIVch0imO7bXY78=;
        b=W/WZcLIsS13GPy2soQ4v7yAwWcYw4QsiJORXc8YogiKH4H5xG3PUTXoC0DxGSL7i2m
         A75G+YcSdzACKofPEw7/U6YBYov3yoxvlaK4yNOoKGgTI1m3rtj0uZo6NIVL9wjbAbky
         gqdQZw/2bZrrBYpXAzUmA8NaHXQNgnxxlfQcOg5FT3kIIRQ+A6FIZANuKCCkySOgcmf+
         3AvW/s7AmdOVd2SE4Dt4kJRl8l4y2WD7u6OPRu1RRpcYQ68U5TgSdW985NFUR+l510DC
         XM5Kutl+Blle774PiN4wT5sMS5FFsbDj9U1ZtS0bynaJjT8pTkwLNJcWpD6wj9zjObmO
         in6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733194290; x=1733799090;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vbgyQ03+F6RIwTN0rVhjgurSNi1zMIVch0imO7bXY78=;
        b=gEjx6VdjkRGWP0S9xUS/OgCg244z28W9JmX2DYw8DXfhIiuCXCx2kqpZM7mA0qtmVY
         yT1bEtE/v8AD7w6A2QE7pGqUJe/3yzQ5q63nZzS+HTo+J6HhB+HJ3iDOdjLQU2DNdyEf
         pp+jWzX9nvuVAZWbi0iW79QEZrVQxpIsu7aE+4ehJpNTpG++gzKKmsslRG6eHJmzycPG
         sABlFewZoGA/HdSS7JxJ+QjiH1oW0i7GbLROqbLovz2HPIdz7k2Qddvxtg7dsRnhlV1F
         s2gAE1YJfaeWNxcf7Gco2mT46FRsOa3R/uzG4lbByF6h5wzIh/5AS7XlkiHof2/OclZq
         yn1w==
X-Gm-Message-State: AOJu0YwlXjacvyBCe5/EMX/8YPX2AIU2WNiJ4+pYCO9V3zX1X92F11iW
	8dsnAoLVhmXYmD4Pkb0d1Y7e+9DO7VxbkpX4FpqAeCMeMHiaIS+sUQttnphFulH1BpleLIqUTv3
	6A8Z34BnDZl/iZ9dP9p/A2CR8xAQ=
X-Gm-Gg: ASbGncuelL2D9IYBte1MhGeCGtrkVgkjHkHT28vTS5uAPea6iCTcF5sRW9oYWP07DGj
	jEx7U4JzDcYVVDecQ3MgXf6VTDM01AW2IJNVYwrFyee2ZEOKSeHl67PZLERNP0V0=
X-Google-Smtp-Source: AGHT+IEf8Ogx5BuwDQvaSYp1m+YFD/p5DqTnMDhSgAvD6+8iKnNmd8ANTGT6O/NcbYJa+o2cIkKiKMtq0NMfXzuHAKk=
X-Received: by 2002:a5d:5f48:0:b0:385:f07a:f4af with SMTP id
 ffacd0b85a97d-385f07af622mr6550626f8f.0.1733194289704; Mon, 02 Dec 2024
 18:51:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128044340.27897-1-rawal.abhishek92@gmail.com> <20241202112919.01dc7ee7@hermes.local>
In-Reply-To: <20241202112919.01dc7ee7@hermes.local>
From: Abhishek Rawal <rawal.abhishek92@gmail.com>
Date: Tue, 3 Dec 2024 08:21:18 +0530
Message-ID: <CAO+A8AK1SeBnB5DDq+HPXiMHRreUgHs-f4LE=LkkWp2jz5zPcg@mail.gmail.com>
Subject: Re: [PATCH next] man: ss.8: add description for SCTP related entries.
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, dsahern@gmail.com, arawal@redhat.com, 
	jamie.bainbridge@gmail.com
Content-Type: text/plain; charset="UTF-8"

> It is good to have more entries documented, but throwing entries
> into the "some of the following" list just adds to an already messy section.

Okay, I agree. Thank you for the feedback.

I think of two implementation ideas for v2 :
a] Create headings per protocol under --info.
b] Update entire --info section for different protocols & its
descriptions. Similar to : STATE-FILTER.

May I have your opinion please ? Do you have any other implementation ideas ?

On Tue, 3 Dec 2024 at 00:59, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Thu, 28 Nov 2024 10:13:40 +0530
> rawal.abhishek92@gmail.com wrote:
>
> > From: Abhishek Rawal <rawal.abhishek92@gmail.com>
> >
> > SCTP protocol support is included, but manpage lacks
> > the description for its entries. Add the missing
> > descriptions so that SCTP information is complete.
> >
> > Signed-off-by: Abhishek Rawal <rawal.abhishek92@gmail.com>
> > Reviewed-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>
>
> It is good to have more entries documented, but throwing entries
> into the "some of the following" list just adds to an already messy section.
>
> Similar issue is true for mptcp fields.

