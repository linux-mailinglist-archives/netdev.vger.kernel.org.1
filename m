Return-Path: <netdev+bounces-191510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BCEABBAEE
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 12:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 572993AC5FF
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 10:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258E6274FE8;
	Mon, 19 May 2025 10:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1gNfj4o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783BD274FD7
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 10:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747649978; cv=none; b=Lljks3XtAnwj/3ef9zLzaWDXBacThkuMoZLIDOZcT5Af6FUZBQGoY4PZP8rzdkgZXelfOjHo/4dxIp2IUTGrJy7UNDv8WYYMuX+/M4bbl3htSPfhsxE6kCxz7vyNBjW1DZO6Gz7/e/HQF8KHPSx7FL54cerG5/dtQYaTDvFtt0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747649978; c=relaxed/simple;
	bh=Rn8QLnQgGuOolqJpjlmKCYN0PFHN7qhHT6cgwyHrfHE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=hmW6kHxYzwPY6msZnY0EhU8ckLoiXonCF2OXMwQT97xVBp3arnmKxvOaCctv+BjtdzWemnVZ00HarLB2QbffPmW7Pj7t6DewfNUvsMp87qj/wXEvmVQaDoeMtbpDoLeOhklKZUF5DoPWt50gie6qq7OA/AvE1HA0f7n669/O8Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1gNfj4o; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a367ec7840so1112453f8f.2
        for <netdev@vger.kernel.org>; Mon, 19 May 2025 03:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747649975; x=1748254775; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rn8QLnQgGuOolqJpjlmKCYN0PFHN7qhHT6cgwyHrfHE=;
        b=G1gNfj4ovblj0MhNSrSFdU0apBAur3UkHxxhqap22uAieqGwGoexzNNLzwFGZEL97A
         mWI3/i8diPiDLFUXYmDY0yTyHK9K3wqsTADUuEqp2fDATCPrvsH/P8mcZ9yl6XO9E2Cf
         O6eDqvweZrkuh1xCVxGEpLiMXw9yMaQlF11A/5D/pKwMkFR5XLp4QOqOCQi2cUx6BPwb
         08iVbI1GwamVRh94n2jx8xVHgl4uEU0rAsZUrlstNvgCMHOg7SlZ7HjryKRYR70SuyAL
         tH1FRlyo7f2FCLCF4UFHPgLPVbPjPZqMqvzPThAt+FA2e4K+zFh2RR1nm+/5jYZPT4gO
         xX5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747649975; x=1748254775;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rn8QLnQgGuOolqJpjlmKCYN0PFHN7qhHT6cgwyHrfHE=;
        b=BJsJ3lHFlMtP2oP4C9MTgLOR861D0daL6fW/WgzGs9UwSGTu7Ww2rxKrhlq/rQ0Bif
         tGvEKZTjh+DBy2hxXcodoqnLUIA4Z3fxpDcKsEY1xy3KbkAtV6v3hnMavCh1TcFpUxAC
         /dvFolv5KM4WGoae9Z48sy6ER2qky0ljk3i42hUZ1OBOUPfD+xnsqExFudWAlyihBAWw
         03lbm/ZTznRRJ5qxHSae9v+VcATZqEbZSCPW5ctvEdOgyhsPDmYklilvyPhBl8sQ2jec
         ItkS0KcSaWCkNwFknXCafB1e1d5KkfgvLPecxtJfuZ9WIHHAMrF90AnhS17/yvjfkjHp
         jvKw==
X-Forwarded-Encrypted: i=1; AJvYcCUnujeMMtEkLdvZByeIoWbUfKlWEA2MkqUEaPbJ61VWfKlso0tI5L3pr0CEGm7k3/JC6kt88iY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg22ikPmsiwmAGlfT3XMmJprWbTyvTe3GjABhAMGr9BK/B7KU3
	NUV7it49BJd+9CrJAQ4kdzO8ph1shVXxTvaczDE0mBnBM/APgVt9Y0gr
X-Gm-Gg: ASbGncsz9CvEStOpyhxI0lnYHECStfdG3DseLRZF+BOlRCIc61eSvNdgim39A0D/qYh
	+NAbuvS/E2KmL+r8van39Dfz2iYwPwbMTPv1atdkKWRGHZVDoVqHL16EmcW7nj2zXW674Skr7cs
	31oAHjkKSLHfkJ2G1f8yOgk9GNYj89m/NNnShGSMaWCpzEv73+4gdC3PKQ3JPLgvgrtEIU3UQK+
	+SHaCa3kzjxgV/Qr3ZZ0DmgdER7qrI+9y7nFNMe3QdbFneR5VGFNuDY7+W3RtNdFrwdvVU2H71+
	+7FmrcMQkKgxVoZ8hXNGtzYbGA+V6d7wV+O2DHUl2EiFDrHFg234+bkm1+KPHysW
X-Google-Smtp-Source: AGHT+IH8XPr94krlQ4vn5zpektK9rXzaWNB2y0fCFuluSmDFGREuv6avkbgMNmHxAyY+nk1ka2FOwQ==
X-Received: by 2002:a05:6000:178c:b0:3a1:fe77:9e0b with SMTP id ffacd0b85a97d-3a35fe7962bmr8834367f8f.16.1747649974650;
        Mon, 19 May 2025 03:19:34 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:d5e9:e348:9b63:abf5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca5a5b4sm12120127f8f.21.2025.05.19.03.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 03:19:34 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  jacob.e.keller@intel.com,  sdf@fomichev.me,  jstancek@redhat.com
Subject: Re: [PATCH net-next 09/11] tools: ynl: enable codegen for TC
In-Reply-To: <20250517001318.285800-10-kuba@kernel.org> (Jakub Kicinski's
	message of "Fri, 16 May 2025 17:13:16 -0700")
Date: Mon, 19 May 2025 10:26:43 +0100
Message-ID: <m2bjrpj6i4.fsf@gmail.com>
References: <20250517001318.285800-1-kuba@kernel.org>
	<20250517001318.285800-10-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> We are ready to support most of TC. Enable C code gen.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

