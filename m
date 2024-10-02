Return-Path: <netdev+bounces-131363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EAF98E491
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 23:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20B9DB2360C
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 21:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8B91D0B8F;
	Wed,  2 Oct 2024 21:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXvm6K0K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E1F745F4
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 21:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727903068; cv=none; b=Wq5DJtRwV47jPmMMAFR06X0zf3Axex3q/kiXM7IQH6gr10gkNbs+dpEl/O5pCtJFI3YsZxpmr8Vdxt7nV9YiMDdAZ4RwjcWRRuVItXRR/pi6xZhRMPu4K2N4bc74buISMH2IXmZeosPZ9cJUKV3WP+eav3jzgcD6gGWL3NR+n18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727903068; c=relaxed/simple;
	bh=xL6ra8RCTOy8ZdTZyT4ut6HaIsLNPeE9HqPN6AWHoBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pNqn7rOM1OOfoQKje+9iAGquNBnojgWfv/g15ZynbB66cD5HcvF0SsT2ip4le2G9V4d7yQkZ5Hcvw4c9vronLdkby4/j2ZjevcsqDNKrDNg1kBwZ9prUZjs5bk7Wt+XGN5XliRAileOtMn/atxt8rYPnvWIg93ZUeQSiPtB7muU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXvm6K0K; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fac3f20f1dso2663991fa.3
        for <netdev@vger.kernel.org>; Wed, 02 Oct 2024 14:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727903065; x=1728507865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xL6ra8RCTOy8ZdTZyT4ut6HaIsLNPeE9HqPN6AWHoBE=;
        b=FXvm6K0KZ5ysKRfF9OTEIaCd5+IyFm3fqQUlO8WmrhT53vafnzmdVJTbxW09hQBou7
         Ebt2lAeyvhrQdIQS6JMlExZRKp0N7xVyPyZRC63nnvgb+sS6nloTjzl2MexEdFSg+pHf
         LG/5LuhLmuaJSZnujSBVk77PTwTx0BUYy8AmxKyeZ4DZJ79isppURZuwittTo3yB1gq3
         8GUecsSrJeqeD8SKNB4hXrmjjeYqfE/SQbO2RPuIFtWp1rJvVZOpEAmHFBar177YmuYf
         7Md29vFjxsIOwm44R0X75vRxq5xnnrEFF8GJR3UoxcfYNVkDZ4N+U6C628+14U3QAeP2
         7H6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727903065; x=1728507865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xL6ra8RCTOy8ZdTZyT4ut6HaIsLNPeE9HqPN6AWHoBE=;
        b=XSoitX9tbKQJMAA9ISQS/BGuX/WWZcDJXfTa1nPUeWwI6J5sfkr4vmIdLcrCCd6W5Z
         mm7SDQe/FKttsj7A6NePEq/Ld0CPzmzTtq7wmaAXMPmt0bYkINSEFbTjJoob59Hcyf7E
         5dX9W5xOlmkwTXavMLjyksEMBifhTq0XW/ietXkMaVrVAUK0ozuL41vOCwbhjf2uPISx
         a3k4KfOwaBgoY2yqj4gwZyjZ6eGgNWrGOQsTnlEiBvvPE/HriwpocBGKDCI1dtvOvmWr
         mSCKBNlzXhOg6r/eWnQ057nTs3AC+aZSrJ/dFoJ6oTzzTtLDE0yN7LW3XiGXgnwitUrT
         2fuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKa9nmnr9f08aZ9XVVi4fOtXdHDkpBKDy/z+nmheIkj03CduhABtX2WcxPiGUY20/JCSDMzIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkUK8++79+vSCRUN0ayJtybKP3A+0rSHNjPKVd3XtcaTuGnmYf
	FZX93IK+GbnoCjxjGTtUu0ksanwHmDJPamt/FpRLXk7epZ1NsAtMMIB7lx6HQJ+HCuNRwuYudlC
	XaRE8lSVw/suVNfZjkm09pwDCnYVaHW5qMw==
X-Google-Smtp-Source: AGHT+IGy9ljUaB19yu8Lh1skRNOWPyDKjSUwN9vTRZ1tno9Ue474cozW+ldsbGwhlJ7b9frteb5d86O4ZlCcLgUsnRw=
X-Received: by 2002:a2e:4a09:0:b0:2f7:7031:dc31 with SMTP id
 38308e7fff4ca-2fae102729bmr26728151fa.27.1727903064843; Wed, 02 Oct 2024
 14:04:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALk3=6u+PTcc2xhCx3YgWrx3_SzazpXTk1ndDmik+AOi==oq9Q@mail.gmail.com>
 <20241002054320.75caf96b@kernel.org>
In-Reply-To: <20241002054320.75caf96b@kernel.org>
From: Budimir Markovic <markovicbudimir@gmail.com>
Date: Wed, 2 Oct 2024 23:04:13 +0200
Message-ID: <CALk3=6sKP_iqaW+4WyOL=HPYc-4QidFEfOK6EtTFTzA+SjGehg@mail.gmail.com>
Subject: Re: Use-after-free from netem/hfsc interaction
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 2:43=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
> Just to be sure - does it repro on latest Linus's tree?

Yes

