Return-Path: <netdev+bounces-191504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30ADCABBAE8
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 12:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EB3D16F6F2
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 10:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF064274654;
	Mon, 19 May 2025 10:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0E8uoGk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D4A2741AF
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 10:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747649969; cv=none; b=WbkWHg5ZJUhaZSoF8RVvGkAlWvZJIon1brzq6zDbOdLn0CZviNwZuHfTFxpMC+oEZT/e1YebFCbscy5pYuPtP96NVBtQgdjkRJoS6Jym9qYDIlSKN3Qn2BaO59gGvQ7bDak8uu1W10onmhpvQ1G19FcfbzUWqxj8uVXF4DOv9kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747649969; c=relaxed/simple;
	bh=Dl8PHTw/Kr/RPW7mpDAD8G8m7VrGmL7fOUrZMGyu1fw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=bAIz0JtPnUbCKgtSPrNn7r0tOV8MQ1fx7Q5Ou8L5UpzGTdMtQ065TAWcmCMvJ/glRpnd8U62ZkvAKLZ7Zb1HqwBlq0uKhueZVgueOoIqFiidvBpO8g++aYVhVT3U2yCrtECFhYpLVU3eLJaTPwr8mBQVRGDFBQllqNaBcGZzHBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0E8uoGk; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-441ab63a415so46909625e9.3
        for <netdev@vger.kernel.org>; Mon, 19 May 2025 03:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747649966; x=1748254766; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dl8PHTw/Kr/RPW7mpDAD8G8m7VrGmL7fOUrZMGyu1fw=;
        b=a0E8uoGkOB1v2TLdnXYnRQbqdXv5BuvkM8uERfOpCy7WZvFvkhONoDUsY/qSFvwCEj
         2B6nnPK9wflU272mH7rF4aSu/+GPuJvHdKYrE4aX9OUTObx9LwkXUsLnnohTsPgg8jOY
         9FlV6XKtzyBXg0Ob9754vummbhlAwv+6rMTNl7YOdDugAquR/P9LwcvnyZD1aQhaEVtQ
         3drSMXyMJDUfGIfd4tUEEsO0OkeCaLCJMTUPOYwr78RZwNZHT7NckUBkDSZbz10L9OsJ
         vQMuSQ31wBWjVf884A7PNTITZGKuqq2LabtXiCLP4MVGvsAlwU7+LKmtUX6P5QpWYVQs
         Zo7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747649966; x=1748254766;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dl8PHTw/Kr/RPW7mpDAD8G8m7VrGmL7fOUrZMGyu1fw=;
        b=BFp8Hrm2HUyi7u9LzJtkZqR5PYT5V7FzASW4Bbq3ZYO6X+FEdRUhGhXxI1gmInZT1s
         Oz/ks71XokRLct+VWQYlHSRPCbzYRVwyzuCz5G60RnS+tUSElSs62C114D17zD48wXdK
         9Y60TQDrwADCXh/HjwJ14VH6qEeV9XtpV4/Ng+yCpqhsjbo5ly7OtddUgkgNn4sFueg2
         pXCyXT5Bl6U2vcsWY1P7Z4ASg/MgIHF4EwSH6IN2EnZKp1Hdt1GGuwCLHYZWJsegMp+5
         ACPPUsUk9k7SE3OMipEdUrn2DKRu3lsIgiUE8KiPEg4nX7lFK+79xr8AP6Qjumq5f4Vs
         pk7w==
X-Forwarded-Encrypted: i=1; AJvYcCXx3I1U92y88Q3LXMLzLanKKwZGz5lhceOl5tyFjTTuk5sGxnKZCZITkSJSoWmqaVr4ouzb6Zg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXC//yoyj9wGBVVG2d8iHd+fbJ8UOpkAxzCgtY/b6Uibw5RuNq
	7bCs8lApDzoZlUhuMUMjldeK8as6XKoASyNtXU3rI2dIvvr19ZJxn6KO
X-Gm-Gg: ASbGncu0nZFAq/pgddlMlpZ39AIr13h6FA+Z1vN7XfbwwCaAV5lPvyn1x2UFveZArUl
	hkGzvufvMRHe5kiJB+O/mS7oFTT7b1nY32HHFlG/CWWfVxuvJyKCmlm1OtGZUlTpiu0FGbA1WiJ
	orJ0jwgWqRZ3nMjjbxJomQKdWk7RtoDStOwGqAceM12wZzuMvntICJzsUuSaxfGNEOgXgp8Wj0Q
	3C3TV9wV7a+SCAo3kFI6xHb7c5x3aGV7r7YMxniyygGFgwjE2fuwjqfsc8icguFEvMKdE/UI4QG
	o0ZtplucLfwxC89OqxeROjpJd4orxwj3J37p8WSNObYhzFuScXo5zoQus9YLnyDRJ9drTPLtsCU
	=
X-Google-Smtp-Source: AGHT+IGnEjBnZCrSv/lBERQObhimwDvRTeA0vih3Jbf+GQT5493zNqRi5mYAS/6jYU+tfoE2Xq8a0w==
X-Received: by 2002:a05:600c:64cf:b0:442:e9eb:cba2 with SMTP id 5b1f17b1804b1-442fd5a1054mr133734515e9.0.1747649966086;
        Mon, 19 May 2025 03:19:26 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:d5e9:e348:9b63:abf5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442fd4fdbaesm141217435e9.7.2025.05.19.03.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 03:19:25 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  jacob.e.keller@intel.com,  sdf@fomichev.me,  jstancek@redhat.com
Subject: Re: [PATCH net-next 03/11] netlink: specs: tc: add C naming info
In-Reply-To: <20250517001318.285800-4-kuba@kernel.org> (Jakub Kicinski's
	message of "Fri, 16 May 2025 17:13:10 -0700")
Date: Sun, 18 May 2025 14:36:14 +0100
Message-ID: <m21psmkpm9.fsf@gmail.com>
References: <20250517001318.285800-1-kuba@kernel.org>
	<20250517001318.285800-4-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Add naming info needed by C code gen.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

