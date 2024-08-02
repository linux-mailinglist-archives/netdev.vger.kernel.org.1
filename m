Return-Path: <netdev+bounces-115190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B98945648
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 04:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EF3D285833
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 02:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C78C18AED;
	Fri,  2 Aug 2024 02:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iI+Qc/fC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB050175A6;
	Fri,  2 Aug 2024 02:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722565566; cv=none; b=c6+AQWR08Y557o9HGOeoAaIjPwlbA3Na0JWG7ymWwR2PWAHvbFrZ/1jgkASwp1FhzazXR0b0UkMeDKmojn5qBV6TYqfwkfQem+hcgbPpdQ/S3uVCu8dGxijDdsvsK95hWysanE3UBymfN2ytC3AIjKoaMfoWIUze4H8ZBju72NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722565566; c=relaxed/simple;
	bh=VB6ZvOs/uC+yXp1dvVIc/2bgCRWtPF3r3G2M+Tb5e/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q3HzZ1UuWDx+RNCIOnHNN9C/n44+vZlBFXrji7nj8bKSLo6Qiq7FFEnfvT6DWZC3rpwRoYGXbyunrxj0hGaZZMNAQ5i2K+k/CXGjyBkQMe6jdh0XGftfW/7W1F2K0SGAdTQPLLcJBsb+K9p/fZaHTtzjUxsWkuGIAS1urkMObKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iI+Qc/fC; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5d5c7f24382so4270358eaf.2;
        Thu, 01 Aug 2024 19:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722565564; x=1723170364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nfyuTMNPkDWCL9I5uMPFKxVk6+FwsBMNlzHehj0YZ/M=;
        b=iI+Qc/fCmzvmx5lKVjRUS/QLgHQZkUOJWpTZzrPi+W5DYDIGBCLQSPG0aS1MMB1J+W
         hdcfzm6qp3H4YcWSRRHjQo411JsKqN1YXVj9BJqmceMIwUQJXPk8DAbrexhiBNHPv/kZ
         ASJnvqDxLoc5nuYdyeWZMVXf0kFSbgtrsjrpTUnfo+UOzB0CVRFUrCQ2cD20gBLiLBZD
         U4fEXciQhjxpAO1P+Dmu1YzPGLpkBy2R3IWckCyJCzZQBmHCRxkg0uA9b0PVVRiNp4V7
         rHzr23a6oWo4ZJH3ytR/7WzAuDu1CHoU7F+Zk1hE3yWDd4BZDN/MTREPhrffMwVVwq2W
         p51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722565564; x=1723170364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nfyuTMNPkDWCL9I5uMPFKxVk6+FwsBMNlzHehj0YZ/M=;
        b=FovegGt5R51nHW9XsNN09ZeV0eV7wi+kSx0vhEOgmTTaFBU1uusvYQRGTRWs8z6A2G
         VzzjfK6pA/+h2IeBTInIqovNHcpJw/cAJ6OUaV+OIKUTpRFWbJJVHmgOibPIKlEZ5rak
         jlsOua7oIEGb1uP3/qTmO7KJ8g28XR6qMobJ0oPCrZnI572WOGOGq1mu32K4gQJ4xf4r
         dfTEx2kjbK2KKNN3AJZEdY1+2r8Gke1iSyNE8z501f7f9kUzvlGofLWSe9wgBUjBZQQB
         paEXVjswv3+8WCesx3FZXFWGyWT62SuyRfEJoJBlNTlK9LZZszYkW9aW1DQQsJRjlDLO
         bn4w==
X-Forwarded-Encrypted: i=1; AJvYcCUka5ClYwGYdsY68HrsjzPY2F3nEr5/54jx890DnDzwUZhY8aF4OtFFuLlUk/F+FrqnaE/xx6qP6YkiOeq0OyHIswsM1Lar25Vk+nqo+KLL9j52AltAGaV6ffFB1dsBlZhFtWF6
X-Gm-Message-State: AOJu0YwGfcuV7awrOu7Hwn6MgOkmUIrKVFXasNTgOqX+Bk3WPb4nqwU+
	WN7mvd8XqF/DvzucHzfd6dCjS0SwjqXZ5O0CdoHvH4TlYwk0YRIeOlXrbQN8fILVPzWwnOnICYy
	sV4MwhIv4Dkcj5gNIiZFbkK9iono=
X-Google-Smtp-Source: AGHT+IHXXXnzi6E9XbW8sxSJCtKQmNHMsr6KIsZI/uoU9mSZgfdMXs+KgK6tJ0JfP9Dvfhl6dJza/sADFiddQgSeIfA=
X-Received: by 2002:a05:6358:4907:b0:1a2:89:298c with SMTP id
 e5c5f4694b2df-1af3ba705cfmr176383555d.14.1722565563607; Thu, 01 Aug 2024
 19:26:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801134709.1737190-2-yyyynoom@gmail.com> <20240801140633.GA2680@breakpoint.cc>
In-Reply-To: <20240801140633.GA2680@breakpoint.cc>
From: Moon Yeounsu <yyyynoom@gmail.com>
Date: Fri, 2 Aug 2024 11:25:52 +0900
Message-ID: <CAAjsZQxh4ykAHTdPryLyv1kePXGB6jZ-mCXjmiCsBusw5ZGQsQ@mail.gmail.com>
Subject: Re: [PATCH] e1000e: use ip_hdrlen() instead of bit shift
To: Florian Westphal <fw@strlen.de>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 11:06=E2=80=AFPM Florian Westphal <fw@strlen.de> wro=
te:
> This helper needs skb_network_header being set up correctly, are you
> sure thats the case here?  ip pointer is fetched via data + 14 right
> above, so it doesn't look like this would work.
I read it once more carefully, and yes, you are right.
Sorry for wasting your time...
It is my first patch to the netdev subsystem.
So... I was too excited. It's all my fault.
Next time, I'll be careful and deliberate.

Thank you for reviewing.

