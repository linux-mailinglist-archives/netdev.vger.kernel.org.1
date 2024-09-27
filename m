Return-Path: <netdev+bounces-130142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D2C98892B
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 18:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 131EA1C21AA1
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 16:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678C815358F;
	Fri, 27 Sep 2024 16:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="et3uIBLy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C745234
	for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 16:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727454969; cv=none; b=ZOmNNzxsyhZk/DC9Oy+eza4PY60gKeMAtLHH2x2ZsImqm0d2+PX4Mlx4TN6DgsmAIvAzSwgChFoccuPowZde02FzdYO2JIGaxZWA8lXr3t6m5e63Vq00V8J0pvimNWzbDNkIW8W6yA4gdu8chLNddOJZT48+/RXWEQPlkNRz12Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727454969; c=relaxed/simple;
	bh=dI90OWQKlkwgIRD2ZLKvzyXwiYiI0T/PPlwoMZPY+D4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=cCLIvyaxuvT6FoSFlpnp6Z/GmeeLQph760tTvl7RpbZhNOvQvxCGtWt5SwJOWbuDeqFrXIx8Hurfew4xCl+Twhtk6yTErJKmJkX2tl5HaaEDyR+oyykaaabBqyVJjreUuNGBK5o2uQ2RwjTbUdJYUwxcxYzEmpJDFAKP64G4ujY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=et3uIBLy; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6da395fb97aso18973317b3.0
        for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 09:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727454967; x=1728059767; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=auk4aaouXFrLk0UPsWI4yOPeMLkriOmuc1voeXwP/6s=;
        b=et3uIBLyf9hWYEK8a4CNNGj1ZRcGpOVEoUMyiVJBdBkp3Upftuq8tK3lH66+wygrR2
         O/41FVS3Qo109J/lUzkjY5qwMNgS94Vrpf4OGXJnQQ1Bed99BdJwwn/DeotgoMjEobtd
         v4mLnrsb/JSeFjdGXWNCipy9/8ugewRZl03oNF8YJNY6OsAVQGlEUR1uIUJyf+uOoJ2j
         Hf+yuCgIgPLxEHKhmZjMnN42wWLekupwvOyIoaojnlAHTlI+Edth7429KAxaR2ZH13LV
         sv8qJ3Dy2afLi6SqE0dTaS+h2s3vxy3zyH0ElJ3EPpFnk5zg/rYnzmb0nvc7vxM3VrX7
         nM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727454967; x=1728059767;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=auk4aaouXFrLk0UPsWI4yOPeMLkriOmuc1voeXwP/6s=;
        b=jFL4l4BwgxFGMjNkQzrGn1tJARf9/li/mHrt+3cC50h3o5QXkibg8Iji1JtYyRUn3R
         g6IBPvnHwIDGtzDQ0BCEgncgQpeN8W0a6XbnhmAyOooofY3YpBjK657tewLnoqbdwGxa
         XIA1kPGPPi/RJNp8IPy3xh1nqWJUlvHydF2x/2q9uY9rkUn7BUgUGOFdFvPhO4AKB7Dy
         ZjFyzPdSCKTBZK2M15jZ/4XTMisFolN8zXoN7sQ6iLMkQvHUWtniYE95RQMt4H4IjR4s
         6PVn7BOBRkgjj77g898XROBHcivA/1N/s8PmV8dcqKh/GoOr33Qcw6F0V9F3HPBZ/fOp
         RCFA==
X-Gm-Message-State: AOJu0YzgfOpsC8tHI2SgaqxCMyMkrkg8Xt0gYNQEjy+V0+B+i1ytsQf7
	3/Svocxk+AhlHTgFY7yxHDthDauVp3mfUra5nLrSlmWoTRZSOX3i4czuHPyyN2Z34heJqW9efk+
	JIQLP78X+DD5jXdnTk9k+430W2kfXrdcn
X-Google-Smtp-Source: AGHT+IHQqZvh3TAjWpnuf0zQvJGDGZqQYNFRB4JWCCXl88uT+MFOxEFu+hwRprHuM0zBWTzoJtpj4j4AeOqbukAzefE=
X-Received: by 2002:a05:690c:10d:b0:6dc:c109:2e9b with SMTP id
 00721157ae682-6e2475f9ec2mr31334027b3.39.1727454966779; Fri, 27 Sep 2024
 09:36:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Greg Dowd <dowdgreg@gmail.com>
Date: Fri, 27 Sep 2024 09:35:56 -0700
Message-ID: <CADVJWLXQ--JKJzRX6JiEdzq5zPwN+qB65B9j7DTRGJpsTh1eDQ@mail.gmail.com>
Subject: skb_shared_hwstamps ability to handle 64 bit seconds and nanoseconds
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello all,
I am not sure if this is the right list but I posted this in newbies
and got referred here.  Anyone have any insight?


I had a question regarding kernel timestamping.  I see definitions for
SO_TIMESTAMPING_NEW in networking options to allow use of time
structures containing 64bit timestamps.  However, I don't see any way
for skbuff timestamps to pass around structures with 64 bits as the
skb_shared_hwstamps use a typedef ktime_t which stacks the seconds and
nanoseconds into a single 64bit value.
I am not sure who maintains this section of the code.  Any ideas?

thanks...Greg

