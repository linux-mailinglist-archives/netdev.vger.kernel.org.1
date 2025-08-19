Return-Path: <netdev+bounces-215064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 899C0B2CF7F
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 00:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C0CE580457
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 22:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7037A221D9E;
	Tue, 19 Aug 2025 22:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iDyvCsyk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD80821B9D2
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 22:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755643775; cv=none; b=iv1zjW5jGRKmOyYn3Gkidhw4iHTWdQ2SMthSqdINtuu6KbhUDwDqEmQU8SKU3++sqq/wuta8XsO/M60i997vogX9ltuBjSJd8VXttQHVXOyvttWkVDSlvKnC4XiguXC+2V9DBx23IYVE12GORtce/RshtTSP4I7jDrEj0tVPs8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755643775; c=relaxed/simple;
	bh=fvxwuSCfRSD+twSz5Gb0eEyXaCFiz+gsVdWdoqPh9lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JgkQDdT9AWBH75vwIcTca4oUK4vpzsQ+/SrXGJgiQC0fpJbt7Uml2jygGJRk61bJithGkE/w1uipXKj3IeFxLymzc6gG6Bmvvge2o+WIO779XEnMoWPrZ3FskLgoAzl9aXa5dki2pz3AdmCU0vZGeMtDZOwE+W1Wc8LMQsumZPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iDyvCsyk; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55cc715d0easo5099e87.0
        for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 15:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755643772; x=1756248572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvxwuSCfRSD+twSz5Gb0eEyXaCFiz+gsVdWdoqPh9lk=;
        b=iDyvCsykgJZcsYsXTohLvX7Ylc1S4wklpRgAb4ynFcENavI6NxuxPsVrXtCOCbu9ey
         foMfJJVbT6mXW3hdUYt8BhHl3/DIe72aXhfZ9Wd7IkLfCAJrM9CQgBNPHtRjEuUeoJ5Q
         z6eocIeH2oGMdRsYDfbWZd5DtgQr9rZWCR4NLHzTu75V0QGqHXHpkl6MYLVxy/tYs5dh
         9xu9ziiK51RjVCTgDeDmz5q78SwNGFlCQpgLh2YkTW1kbvrgc17SFeNYvs6salU3dC5h
         hUybR4tx+0LPa4MKKKA0ZUalYimaZJqXqPHr/LSK1yX+LJgQxJ1g6mKtUvkYmseGhPyn
         SA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755643772; x=1756248572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fvxwuSCfRSD+twSz5Gb0eEyXaCFiz+gsVdWdoqPh9lk=;
        b=n3xdaGznnJhaWZui94BbTZ1ypqx6LUh/G/Sw0nIiLv/pZUZV7g6F7+IGtbfaFdV4DE
         XEGtvfO4hcAExijdwsJKqoRERtpX+L7JaYOKchI+jViHdvLjaeEc49J5NWNx0th1ApD1
         G7HejKZLqN3Az9jXyGFPUCCX8wqtDYhXsLZnvStQr1nk7hPdK5dWY3WpYMW1MROMrhF1
         Vzp7KKs6nAmRnf0y0CQHZJsvhmFjAIwc+BQD17W2WRIkTocKDNTqqVOHvTeZ7oEwgLbQ
         4LmlT+1tnEwljEIupVA+VRNH0WC7xbU8U+MwTLBPxHGuvQsM3rR6Vhs7qFt7mD9G/0Fg
         9GRw==
X-Forwarded-Encrypted: i=1; AJvYcCW82LC37WxcxjklDdEiKuQD64iUg9GoyzK6bpaLgOLGTCAmPHLABkBPaaSSvKysOsZH9XbKKKc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3smDDlTC+MV2nW1vVTajnSq0Gmn77scZLGcJnVKoL8MWyr7q6
	XTQ2R3eEoSvREMeKOeoJ0l2+eilknz/l3PqHXHzvBuE2+pvIvWDGPwb+Tfq6xRInl7g8F46dHb+
	fjVw/IJabIaxM1sWb/vrLoNtNOwXE9drWU1h1DQ90
X-Gm-Gg: ASbGncudsxxN4/HHDuMNOOnJBd02gOXmB9iN/GaBATbm3Fhnrrw6Gb1xyK1nvq4da7I
	eLN0UpLAzdzU6YH1VF8CtBmyJMzZPnN2a9KybUG7cBsxspYh4coCo6U3lICdQpUDPXbXcZcmYHP
	blaGZOFG+KOwNVkJLPTnxPGbkJIYGHdV1+oi5o4v03zlWkUdGSDkeAwz0Pb5Us3AFfOq3GBgsv5
	s+wuMOTXazFfXK5il9+BjmmSA/hjPBSrColyBSI43stxeCtvTL3cCo=
X-Google-Smtp-Source: AGHT+IEmYxxYzU8DjQH4U3y7gdcuj6fyI2P2sUFUnAoDbFPxhCsmZmBLl5HbvLkotXIKN1zE2OsjYMUqPyw5kzo6ryA=
X-Received: by 2002:a05:6512:4388:b0:55c:df56:f936 with SMTP id
 2adb3069b0e04-55e06818947mr113782e87.6.1755643771563; Tue, 19 Aug 2025
 15:49:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755499375.git.asml.silence@gmail.com> <0ac4e47001e1e7adea755a3c45552079104549b9.1755499376.git.asml.silence@gmail.com>
In-Reply-To: <0ac4e47001e1e7adea755a3c45552079104549b9.1755499376.git.asml.silence@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 19 Aug 2025 15:49:19 -0700
X-Gm-Features: Ac12FXzsId0yCBo7YoLtpLEhq9SLD85yb1Q2qrwcLNfXEbhtrBTCgGQJ0OuhPvo
Message-ID: <CAHS8izOkTpdMSn+0kWYL=qi+WrTy7b=qARXxWjOMHWEKdHZWaw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 19/23] net: wipe the setting of deactived queues
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, andrew+netdev@lunn.ch, horms@kernel.org, 
	davem@davemloft.net, sdf@fomichev.me, dw@davidwei.uk, 
	michael.chan@broadcom.com, dtatulea@nvidia.com, ap420073@gmail.com, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 6:57=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> From: Jakub Kicinski <kuba@kernel.org>
>
> Clear out all settings of deactived queues when user changes
> the number of channels. We already perform similar cleanup
> for shapers.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

