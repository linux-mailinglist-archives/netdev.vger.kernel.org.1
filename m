Return-Path: <netdev+bounces-98261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5048D0626
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 17:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4959294217
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 15:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E42B17E917;
	Mon, 27 May 2024 15:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CJSDMwWN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE2B17E908
	for <netdev@vger.kernel.org>; Mon, 27 May 2024 15:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716823430; cv=none; b=tFWqZ6HfA7B9lsE67kkYcumqJ/5vVWonbdr/n7EYtfw/qYNk9bMhXwDBVW+Tjy+j3t3i+bl1PnmDwDkTW/Fg1DmONq18kZwtsLnUNlaezVsWKHg5bPj9uq3dbCFB2ZP62xWsp1zsvdaiD6hZzQjnGN/xKqU1ft497bJqbN7wGgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716823430; c=relaxed/simple;
	bh=rX6Mr8H9PbEB8Nrj9fFUHV2mAOv+AGDZJDj20RP9pWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MBGeB01dl/pe+G6ZIyrGTfB3oKL39dw815NDBYzrB9N7cHi9w169CVfhTxvCgbZl6xLaCuWdc8vDlM6NcSh0W5Bxtbsu+A+6gWnbgyaMCMrJY5OcKA35wCEyC2UQdWZhmfO0Y8wOVBDdSjJBUZ4cqNH1W/YCDM6yb0MVOc5tduY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CJSDMwWN; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5751bcb3139so13023381a12.1
        for <netdev@vger.kernel.org>; Mon, 27 May 2024 08:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716823426; x=1717428226; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J6TnsN3hyZ2OmWrwgdcT2rAmhOzue21klQUHKehJR/Y=;
        b=CJSDMwWNjDxUtOs445KO6tNnsRyCuPFFvLlj5heUMOE61oy7tyMjndN1VFzXdFTQ8w
         OwDXBl/Qz8cDMDBEX6YzZh/2+lRfxGvdohyPbawmsH4Dv3RDWzjbdLaslAv24cHQnIoT
         sbeoBV5J1fRm9o+ydvZPkBdXaHBjx17Y8kf6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716823426; x=1717428226;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J6TnsN3hyZ2OmWrwgdcT2rAmhOzue21klQUHKehJR/Y=;
        b=ILMypvMQIdQMMfspW6s3w16S7zQmHyWD0yGuviesHmLnyJ5zjT0TOJ1UrRBV40x7FR
         NEwwu830jNHDUm7/SOpjjsN2vzZiPKKmC7avOBw219EpfvnWVHtzGN4+e/1GWf1xFPvY
         9Chhn9Yo0kyIIfmdK0BR36fh93/YZiHvauxRwNTKfdRRujioY/bxq6fzO4zpgf5gcQDa
         IJLTiKbY6FBnHbbK0m8BMCV7OE7Q49Re2W/fWYkwmb2YBch+HpVPJGQ4eCR1LYdBwxu/
         XnHNLLeRX7HQtK9OIWKojmmw0M3yLsOqUPKhKuchJKBwYKgqieOlxuv8gx9bLa0a5TWX
         gwKQ==
X-Gm-Message-State: AOJu0YzOPz0rAEHdKDiIQxfftLBflKqpxQpAkhkAgQzfXalXXyPeP4PU
	f+u9Zsf/mFFHRz4QZy1znYUemHVjsXE0nFRBl0CfOkYCA6AsXo008ULKtRV5S5FRQRZBgClmQ8m
	ubUN8Pw==
X-Google-Smtp-Source: AGHT+IFQESCbNUU20Yf7rZoV6BbS/V8TxG9XRRRUV8cCVl7Xw4dCTQPcD9ESClIGfO8hkaYiGk3UhA==
X-Received: by 2002:a50:a682:0:b0:578:4b46:7ac6 with SMTP id 4fb4d7f45d1cf-578519be672mr6800616a12.27.1716823426231;
        Mon, 27 May 2024 08:23:46 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-579c571c71dsm2785792a12.39.2024.05.27.08.23.45
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 08:23:45 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5751bcb3139so13023353a12.1
        for <netdev@vger.kernel.org>; Mon, 27 May 2024 08:23:45 -0700 (PDT)
X-Received: by 2002:a17:907:7005:b0:a5a:2aed:ca2b with SMTP id
 a640c23a62f3a-a62641bbbb8mr669128066b.28.1716823425038; Mon, 27 May 2024
 08:23:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240526034506.GZ2118490@ZenIV> <CAHk-=wjWFM9iPa8a+0apgvBoLv5PsYeQPViuf-zmkLiCGVQEww@mail.gmail.com>
 <20240526192721.GA2118490@ZenIV> <CAHk-=wixYUyQcS9tDNVvnCvEi37puqqpQ=CN+zP=a9Q9Fp5e-Q@mail.gmail.com>
 <20240526231641.GB2118490@ZenIV>
In-Reply-To: <20240526231641.GB2118490@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 May 2024 08:23:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=whMtdD37OJ7ABVuBi+JLkG+ZcuXf1+cwC=J+H5B3EASTg@mail.gmail.com>
Message-ID: <CAHk-=whMtdD37OJ7ABVuBi+JLkG+ZcuXf1+cwC=J+H5B3EASTg@mail.gmail.com>
Subject: Re: [PATCH][CFT][experimental] net/socket.c: use straight fdget/fdput (resend)
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 26 May 2024 at 16:16, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> FDPUT_FPUT is *not* a property of file; it's about the original
> reference to file not being guaranteed to stay pinned for the lifetime
> of struct fd in question...

Yup. I forgot the rules and thought we set FDPUT_PUT for cases where
we had exclusive access to 'struct file *', but it's for cases where
we have exclusive access to the 'int fd'.

               Linus

