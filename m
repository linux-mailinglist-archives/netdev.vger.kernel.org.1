Return-Path: <netdev+bounces-198588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 451FBADCC6A
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 15:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6190189C310
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 13:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C27D2ED86F;
	Tue, 17 Jun 2025 13:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxCDp4l1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A592D2EBDE3;
	Tue, 17 Jun 2025 13:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750165216; cv=none; b=VMDlUjnSF5pJqUUxk7n2EfKR4ZdLnzgGJXfP118ptQTlCqGS6qSqsDinAF1JNrQNU3c+uNVUwhAxCqz8dLjR1/YvMQWP6ok8pTvGYhw48v5oqr8MxUMgzELsI82SBqt7ng22+SBOkNmqETr+yIewIe6h89ggMLh7SxG9nkN6PnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750165216; c=relaxed/simple;
	bh=U+2BrFcs/WNvZ2BeNf0LFR/mmC+ALZlnCYcOkB3I+lo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=nOoybNQO/iILELR1AYmm22VjnlXzYxynTASQ+Oy/wgA3dj9neIO6lK7hfCIN/tZ7pP2jw0Kd8sIEFmPb3SEmBnU7sdxQt3PMmIR248UUBui2VT0EydJf839THnUwS3MYPOHhM4Z9k+PV3mlmsZisQu74ZwXHXqKmbL1C7al5ZCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxCDp4l1; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a53359dea5so3931286f8f.0;
        Tue, 17 Jun 2025 06:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750165211; x=1750770011; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U+2BrFcs/WNvZ2BeNf0LFR/mmC+ALZlnCYcOkB3I+lo=;
        b=fxCDp4l1gIvk4JUfd3v35PTl2Itek4Q7DgEVgTBt3JHMC5E0JXf8659RJ30cu2Ndbh
         u4YMInLwkytN0Rt7Ay1Hykc5u5Yzlbmw9PN0Hy5jJ1XTnSum2EIkPVDg/ABHr1MmwAuh
         4O+yN8Y2Sc+NxhlAw7nqAg+Ma1dPZFuRAUHhqKFCrPqJWFEiRlltl24lasxyBjsathuJ
         l8WpmtgUfsNHdINVaoqsK5XgKhfCnSwhAYQq33kLqcyurAcxKiFn6Px5M2pmmaZ98VTx
         4BMaw6jOSw6AJ4hBYZnr99F9qNz9mjfNN94ifLKiuSjHPkDLylTa6tkBb04TYqo0fo5f
         mUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750165211; x=1750770011;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+2BrFcs/WNvZ2BeNf0LFR/mmC+ALZlnCYcOkB3I+lo=;
        b=r1DfpkcG68/Pjdvby+6qBsULdYvPaPXu5aRQBo6Ut0BAazKNy6Dt5CzUD9trS2d9nl
         tTsPf8Ag1EXbNMZ6HyvDi/QyVkfXa/KzyDoc2EhGnnjq6/0hQZtoeIoxbDgozOiy1Vjn
         n4DE4TIXKLjUWrMfz+qlPF42G/Gbmd7XzZ2wH5LBR6GwHUBNHOXsDgfQ6Mm6vnX+zd5r
         lBbStMaXj4Vs8U8d8mNjuUF+9tY8FvoK788PJEmburvCp9qOOXIbRfG8IIihF1SrmUTC
         rudyBZJYMQzFghsxr858ccw9XYSPxJnX4UMzkYGbL+QGOjwQAvvahsLaLEuzVmQOdJQu
         lbtw==
X-Forwarded-Encrypted: i=1; AJvYcCUp3XQBv4T1QR0PKKE4GOLlaTYluqgHbdrSRcN93wl30GW/21g4g2e579ngtX/Mv/cHHwTpLfUG3AG6Tf4=@vger.kernel.org, AJvYcCVRpW7nKpHAtiHVHostoRQtOt726WI25zVFGNx23BPP3b7FKm5pNxLJi3wFiNVE6LgfUqBurKA2@vger.kernel.org
X-Gm-Message-State: AOJu0YzFyHRqqjKmtUO+uiw8B+uXsXrFn/S8l+vAUN3ZzVQjWNS6am6W
	1xa7kA0foTtHJpt+7JbpgMMW5RlvOhZ+ow0SGN3CB1ZY8ZigH4MPkUHvZKlxr755
X-Gm-Gg: ASbGnctUCh6QNw5OmA6ObA7KrDvkHNyx4sp4+R1M4LaJtyy72z4HQ1/Jsdu1g8iD/2l
	GZ6Ysw0QNfh2FQ3cdUEu0bOSBE+xpc3qonssroY47YB/614dG04zi9vrBoL4ny44s3eCSm8afB4
	ONfwkAcSJn3tKaE17hCs9gimH2cdcfCytwnoc3MfIoMAx40kng/K4csTG+HFnJaM6kCNr8iee+j
	Ikh1ew5QucjBnldMs4voSdVV4Kn9CfkYoak+mhBrBGcvmVX9C1ztfNBWI5wRY3koeLUMZLlYgfG
	dRr2//0zpJb3FA8gv/L92fk7JsSPePiH4+dQzvFHZr6WzLU6QToODzGrFzV/42E7k4+vLsvHnoU
	=
X-Google-Smtp-Source: AGHT+IFAOftRNr9UArvb/ayDqecb5pQMF3c/jd+7G9PdWPODKXwcXgkgZu8aWMDVJ40l2sMdirRwTA==
X-Received: by 2002:a5d:5f84:0:b0:3a4:c8c1:aed8 with SMTP id ffacd0b85a97d-3a5723af1d2mr10004080f8f.39.1750165211307;
        Tue, 17 Jun 2025 06:00:11 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:8931:baa3:a9ed:4f01])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e09c21esm174344585e9.17.2025.06.17.06.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 06:00:10 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,  Jonathan Corbet
 <corbet@lwn.net>,  "Akira Yokosawa" <akiyks@gmail.com>,  "Breno Leitao"
 <leitao@debian.org>,  "David S. Miller" <davem@davemloft.net>,  "Eric
 Dumazet" <edumazet@google.com>,  "Ignacio Encinas Rubio"
 <ignacio@iencinas.com>,  "Jan Stancek" <jstancek@redhat.com>,  "Marco
 Elver" <elver@google.com>,  "Paolo Abeni" <pabeni@redhat.com>,  "Ruben
 Wauters" <rubenru09@aol.com>,  "Shuah Khan" <skhan@linuxfoundation.org>,
  joel@joelfernandes.org,  linux-kernel-mentees@lists.linux.dev,
  linux-kernel@vger.kernel.org,  lkmm@lists.linux.dev,
  netdev@vger.kernel.org,  peterz@infradead.org,  stern@rowland.harvard.edu
Subject: Re: [PATCH v5 14/15] docs: netlink: remove obsolete .gitignore from
 unused directory
In-Reply-To: <073835aa035718b120971b7a53e0f270d146fe87.1750146719.git.mchehab+huawei@kernel.org>
Date: Tue, 17 Jun 2025 13:38:11 +0100
Message-ID: <m234byk0gc.fsf@gmail.com>
References: <cover.1750146719.git.mchehab+huawei@kernel.org>
	<073835aa035718b120971b7a53e0f270d146fe87.1750146719.git.mchehab+huawei@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> The previous code was generating source rst files
> under Documentation/networking/netlink_spec/. With the
> Sphinx YAML parser, this is now gone. So, stop ignoring
> *.rst files inside netlink specs directory.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

