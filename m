Return-Path: <netdev+bounces-156034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB1AA04B5C
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 22:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D2B63A2595
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 21:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D68B1D63EB;
	Tue,  7 Jan 2025 21:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pxwhEv/j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96643155300
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 21:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736284122; cv=none; b=kClke7xsEw6f/IP6P5v90ij/8jDg8+n1pQ241oDbq0KbhZW99i802zbXLW5/qTZ2kFW4M9i46N/aL0lQPwyEMxYm6x2slPTN1yhmvQw5NgOwI77HsWi9O4eA3YIT83UJaWvvyzqCj2pJKaqE7yzrkOVhuo9K+sEub+7G4XNmIOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736284122; c=relaxed/simple;
	bh=bPwaj1b8EkIxxT8YJlEskLxJb6f3W2CP1MBEle6katM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bAZK4T5O6zfFxJjjNdog1M6+BILz/g906dR7+DPWWoeR8x2OotqrQWFiDGFR/IcCo+bnTh+Aq28UgVrWuuEUdHCw3LIFbDNDm+aE7k2RP2fjt3b5mpdDptKlp9OduDFnt/2drSfsItc5ZLX+mdSGsOVY89nTpHy5xAsFBv2at88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pxwhEv/j; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-467896541e1so60881cf.0
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 13:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736284119; x=1736888919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPwaj1b8EkIxxT8YJlEskLxJb6f3W2CP1MBEle6katM=;
        b=pxwhEv/j3IILTvaebvbynMOO7Yp46D4untXnAq5HxxV778W4VmgSyCS4UwOTD7W0iV
         flvFwSGna8NcaXt0mw0WcPdJGUtaTImbN+bdyrHVcZHSU3hLsql6+TJ6eSgnwSKhycMN
         9IpCEfYNnvUzSxGDyGcGGIo5u7dmbEJEI2wZC2O4oocX3GB2eKtd/2xLMA8CSaAcaDOY
         4n1oqohoM3FTvpKFvHZx2MNI40XSfguji/VCK263CKP2302/9MZf7UrKEcAeUA3ihNI5
         2suul7sk1+I6HNjyPxwEgQGBkvVUJrGD+PODWvN/KxJl7kcAMu9Ym1Ke13Pnok88bgC7
         rpjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736284119; x=1736888919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bPwaj1b8EkIxxT8YJlEskLxJb6f3W2CP1MBEle6katM=;
        b=m1E3nO9iLbxdrZSvZ4t4WJEbCuu+d8QdV9Z9EC95Z8msiHJRbmwbCNex171EuZq69R
         OWl3XDbbQWnC0A6h+s/yiL0skFBmhdP9gMnc3RIefdl1c9mF+CcxOJ9rkRJSxs89iTzG
         4nSfJqjJgwgcHBBw6KTtNIq92fYVWQoTbtM0dlXtUBQj32XTcdOEDslPQPPdKozHokU1
         ENcF1ogkJj0kg/8vNBUK+hL4AFFITHTVa9vFofuXr+VJ1QDyL4ZUSFRrj1PesxkWHwuc
         h5k0vFE4sBXuaxkL79St6A5TAlaY0QLGFmkXowwl6oelrn59DXxFTnSHKyqktn6dBB10
         r+Vg==
X-Forwarded-Encrypted: i=1; AJvYcCW3C81NiYa4ZKj/egkaIN1iL+379Lb7j6RlwcMpAAn0wMHsMg15s6fYURcwfFYxDzZ757474Do=@vger.kernel.org
X-Gm-Message-State: AOJu0YytqJ8lg/7oSBhOYf0zfwYfBoDlwRaKMy6wEKaAzhPn+mYZVtWT
	T5RfmaIJKHbhxKehP7I3eEXr3BJ6BT/odV+q99+HI0vps5DD/OVvv0DV2clM3x/mlXY41tD8TCB
	SbaMfNYUvUfnVxJZGr950U2B4KTOiGODGsR9a
X-Gm-Gg: ASbGncuGyBXLaIB1ObwEUuW2eSzg4XJpfH4fGXe6vhDjUBCsDA1ANvSGTyZmlVbwqyO
	xl6/CcWn+UDVV0fvHc4/uz1hgFC7P6IT+I9pgl/LJZmeA0PLdpaK1SDURUilJw8vnwbQ=
X-Google-Smtp-Source: AGHT+IFp7eksbpGK4zK5byprjj7GtTtmvJHrNJqAUr+apFNmiH3vcO9leFADIOxcs5kdDBsYsXsMifOWGFuxWV6hVPw=
X-Received: by 2002:ac8:7fd4:0:b0:465:3d28:8c02 with SMTP id
 d75a77b69052e-46c70cb7681mr580421cf.26.1736284119493; Tue, 07 Jan 2025
 13:08:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250103185954.1236510-1-kuba@kernel.org> <20250103185954.1236510-6-kuba@kernel.org>
In-Reply-To: <20250103185954.1236510-6-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 7 Jan 2025 13:08:27 -0800
Message-ID: <CAHS8izP3meH1Ci18UOutkQNqGJBTJ=rxvNNd4jkmyYBi5oUFkA@mail.gmail.com>
Subject: Re: [PATCH net-next 5/8] netdevsim: add queue alloc/free helpers
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, dw@davidwei.uk, jdamato@fastly.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 3, 2025 at 11:00=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> We'll need the code to allocate and free queues in the queue management
> API, factor it out.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

