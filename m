Return-Path: <netdev+bounces-184506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E694A95FFE
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 09:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCD71178031
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 07:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FAC1EEA3B;
	Tue, 22 Apr 2025 07:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YrW6QqHY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB0B1EE7DD
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 07:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745308355; cv=none; b=qh5U5nrDqHvjWBr8Zurcbll13QEnOc6YnHvUqIK5jHpPLJ8PLf30uhyWed0VleNxcTE3Jlm3+6aRHvNrgF4h8iPkTX6QBZDfkie5p0504BLYvDMKp0otkSLyPUzhLYWcCwID2YiGmKzAulBjFvsR7KEKRmWMwiQ7ODORkT6KJGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745308355; c=relaxed/simple;
	bh=mdja1zPwi11rl3j2lP+FosY/etFHJecqSbnzsbEbdzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QAyePr2upTaEav3r3nSzvTg0NNZl0NshPl+kqqSpCyfgMCfeJoqLbG9dwSeP54DrrACeWTKf5h5yuMtZmqW+o+S8ue5QiXzhqZyky109zg1U2DVRcqQ/cx/N9sq7cspH60PKfuD2GBtb2J8KewaeOabfXJpA2f3BdQ2+XFdPFE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YrW6QqHY; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54d6f93316dso3582911e87.2
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 00:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1745308352; x=1745913152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wr8zkHOcjJp8JH/D5R9zZ1N0PkwxRBvn2f61DwoqQx4=;
        b=YrW6QqHYMSXMXFG4BFWLnIMOusSnNpuwDIwYfVs7Q1qTT/7KAmFWl9i4XO2EOJjXoQ
         yBHSxtTxYr1wTtZB5oJBGG7eh38na1b+0fegCbUX/MLNxhTBwZFcHZFzRh+gAShkeyHX
         cKWwOkktdQh4qMuafKJhk0l2wXP+rv0AY+26A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745308352; x=1745913152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wr8zkHOcjJp8JH/D5R9zZ1N0PkwxRBvn2f61DwoqQx4=;
        b=XpjziF5ZLqVXgKPw9+PwFx/1q8OSXvstdXrglCiwQxCLqvK0GZ34s9vV2qIQM++JJ/
         yGp3c1Dtrp9KMrylwVWcKyFcSYO/zjOcv1whjhnfNgoFYza0pT06lLzV6E5MNzT5x5ft
         e6zy4kDM8u8xgOEEgUXZgNeJkbwnRlJ5V5r348jB0Xw2f8rD5VCsLpqRZ5+O1zur86qm
         Cp8cwEcC/RZHiy0xEkmaYqtW87BESHeaDC14nPbv9IjsmAQbYP3KU0bJzi3JTYroUFQZ
         bFpsErJIuljkZ9JYfv+6x1zYO7TeqwcnqIL2Yw7EDiISkKK8Nk7C3D8eyBol5pP1yJqB
         sO3w==
X-Forwarded-Encrypted: i=1; AJvYcCVD5C9MAavlf29ijMuq1o9F43k275plw+4P6Vlrq+cs02Xj4jkYtPzamU88g4viWsJolFSUSR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZf7mMHnDWxVW+G3WCZkuuWV90B8zdREzhqp1JnyvPrvvD2yAf
	paV9dDQyoUG75Hwb5W56ux2YAmEInFrd7Zgf/jcwvUMEY1TOcuuylA4qoZZnCp3GHcYb9mh6Gu1
	Ty0LTj8mJWTjF9XsbDUtf4UtvQZs1OH4V2Jk/
X-Gm-Gg: ASbGncvCwYbe6JIq8keR+M4oUjJaIutuH8tpjE286Dfi0G43HYJSoiQZ2gkU7d4Cy+A
	SOyAmg5t0pxoszjYggCnZhvXw9zxKweiZZP3UTxJYJ3rD0Uwo0ARtt+fYASOc2r33AaodhvnToF
	nQhzjMa+bOfODIBVjPf1bOdw==
X-Google-Smtp-Source: AGHT+IFJ6lcJHhs4les/hHMElmGqx/Gs/phTM805DYAJAK3V4MGWnxBI1/ZYxVFXtSykbjyfqSGPHxrZlSGhtLEvNSA=
X-Received: by 2002:a05:6512:398a:b0:54d:6989:919d with SMTP id
 2adb3069b0e04-54d6e66c955mr3838846e87.54.1745308351721; Tue, 22 Apr 2025
 00:52:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417002005.2306284-1-dualli@chromium.org> <20250417002005.2306284-2-dualli@chromium.org>
 <20250421151807.GQ2789685@horms.kernel.org>
In-Reply-To: <20250421151807.GQ2789685@horms.kernel.org>
From: Li Li <dualli@chromium.org>
Date: Tue, 22 Apr 2025 00:52:20 -0700
X-Gm-Features: ATxdqUGEbodkKiKzPD66g6rMQ0PQiXs-yAUyfR5qae67BGBgscO6cW8-1gvL2Ck
Message-ID: <CANBPYPi9+JvWOAPgOZLxq9dM9PX3-7Tz+_GnUR_xOKbtjdu8yQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v17 1/3] lsm, selinux: Add setup_report permission
 to binder
To: Simon Horman <horms@kernel.org>
Cc: dualli@google.com, corbet@lwn.net, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	donald.hunter@gmail.com, gregkh@linuxfoundation.org, arve@android.com, 
	tkjos@android.com, maco@android.com, joel@joelfernandes.org, 
	brauner@kernel.org, cmllamas@google.com, surenb@google.com, 
	omosnace@redhat.com, shuah@kernel.org, arnd@arndb.de, masahiroy@kernel.org, 
	bagasdotme@gmail.com, tweek@google.com, paul@paul-moore.com, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	netdev@vger.kernel.org, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, hridya@google.com, 
	smoreland@google.com, ynaffit@google.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 8:18=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Wed, Apr 16, 2025 at 05:20:02PM -0700, Li Li wrote:
> > From: Thi=C3=A9baud Weksteen <tweek@google.com>
> >
> > Introduce a new permission "setup_report" to the "binder" class.
> > This persmission controls the ability to set up the binder generic
>
> nit: permission
>
>     Flagged by checkpatch.pl --codespell
>

Would fix this typo along with other changes in the next version.
Thank you for catching this!

> > netlink driver to report certain binder transactions.
> >
> > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> > Signed-off-by: Li Li <dualli@google.com>
>
> ...

