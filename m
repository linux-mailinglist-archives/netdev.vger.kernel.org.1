Return-Path: <netdev+bounces-106143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B5E914F50
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 15:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ED121F22F36
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 13:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2F91422D3;
	Mon, 24 Jun 2024 13:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zKSqq3tb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EFD1411FD
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 13:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719237432; cv=none; b=A1xX2LO/ExyDsbbxGs102nMbld9yQvc0wXRqG1zuDvJlONVi9odiCok19dBTOBRI29yr6JQMqzOST4I2jJ/h6ufP7ABGOlXIrxAcL8g6PmO+bDZvUCLkkY8TH0gT+8c+TruOzx5/uuS0HGqETYvvb/fMVJ1zPFUYAOStVRrVplo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719237432; c=relaxed/simple;
	bh=JcmBNUGTwoexd4d4Kt7dKugDN2tASyAOaxDUgR2FYt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eyTXXWgMqtYrcKF3Du+uSrO1bCtN+ZesReCbynOZiQ3Fisrz2SSD02w2EEX2NTVGu/KfoK5g9tPZFQ9vT3t2NmngDu7zFE/TCv9K3yul61dR6gPjzmmAVpyh8K7gCEK42zgQoj8vOYOiFk6mjhRCApJqVBSCzLPWWkEOwQGp9zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zKSqq3tb; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57d119fddd9so23434a12.1
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 06:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719237429; x=1719842229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JcmBNUGTwoexd4d4Kt7dKugDN2tASyAOaxDUgR2FYt8=;
        b=zKSqq3tbKQHF6xoKyLxyN0BCC7BIOE8OriqJqlAx+ak1rHc818BjLW0eLEeL4/vXtQ
         cUDdaoHBVk1s2RDDYorX7g64gvuhTHt008wBpmdujimn48GIepFPScIWgXKH1u2tjRHR
         UbMNjp6VZe53F0O77pn1mK/88RfK1tsQnDR0bRTV3SNwIOBCF8eVjsn6nvFyX7tq54ue
         jxRxbr8hjQPLb7SaCsbxu0TLsiNGqVvIYV1pxveVAsrIImXPQU3m2f0p5lYP3ddvH1n9
         EBdnD+3izPVskyvaeOv0oQEo+nvTggR0xb+yb8egj5dd+QAccqciTRZ0Uj03jDAFzqNO
         p19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719237429; x=1719842229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JcmBNUGTwoexd4d4Kt7dKugDN2tASyAOaxDUgR2FYt8=;
        b=ZAKML2IZKQ9YkYgeVg13YmaI/dJhWyNJsGYJY3YgRJ4zcl4l4CTP6Za2tIkBu+KaQR
         3OcSLHJTZktuo1XGTT79XQ7PeH9X+e0tUONpzCwEst7aAmj9gdNtRVKk9LBCTnPUU3kI
         NvSUDJnEIXlnJy+sgwZTFevMtyBfE3eEa/UYSzITMbj9q27uJzRy/G5QRFxwB7QtBH4L
         /fTdSI37/6iQyHK75ECwhIeuA1V40MyyHaCssEPcBO5hxz8nGJv366orTjrjekmIA5Ba
         5ZAF6ucAUIIrOd9uySlAwVJmG0L/WtY0zk8xJlQoqt0SswmxezID/+FeUoCNXhtZ6o9o
         FXdw==
X-Forwarded-Encrypted: i=1; AJvYcCWMLYwF+HGc6NawIuLHMXN8tlpJOs+E8DN0Y+ZEA0hd66C5XV9w8tzfX1SEyhEGnNyXHf35JQo80Z7NS9H+ZJM10Rl/MbtP
X-Gm-Message-State: AOJu0YzqHtz0LvebekjG1ytqs6PjKbVcL2n/5RHkWleZz1M4AmUiCuuB
	CIdS0xDhnPa1Ma5QWzhGvHlPa6hdOqczXWut0NKV2pi8/6A6sxJW4MZyvKnM8uCr1QAOLpqXyuh
	0evQ7NcnAXApTIRIJro8LR9kmUIV53QJXAEJM
X-Google-Smtp-Source: AGHT+IHbiy1mlgv62NpSfQr4qTZMGNLyyk2z/JSEgEj2oQ6KuAX1jpFmQzh/as79B6TsYRiexfxYk9JCRIbRT718SCg=
X-Received: by 2002:a05:6402:3549:b0:57c:c5e2:2c37 with SMTP id
 4fb4d7f45d1cf-57d419e2fdbmr270398a12.3.1719237428649; Mon, 24 Jun 2024
 06:57:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621013929.1386815-1-luoxuanqiang@kylinos.cn>
In-Reply-To: <20240621013929.1386815-1-luoxuanqiang@kylinos.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 24 Jun 2024 15:56:57 +0200
Message-ID: <CANn89i+mrA0CpNLvOCpNi4XS1XsftgAQu71jWb4Ahh++VUzkGA@mail.gmail.com>
Subject: Re: [PATCH net v4] Fix race for duplicate reqsk on identical SYN
To: luoxuanqiang <luoxuanqiang@kylinos.cn>
Cc: kuniyu@amazon.com, kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com, 
	dccp@vger.kernel.org, dsahern@kernel.org, fw@strlen.de, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	alexandre.ferrieux@orange.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 3:39=E2=80=AFAM luoxuanqiang <luoxuanqiang@kylinos.=
cn> wrote:
>
> When bonding is configured in BOND_MODE_BROADCAST mode, if two identical
> SYN packets are received at the same time and processed on different CPUs=
,
> it can potentially create the same sk (sock) but two different reqsk
> (request_sock) in tcp_conn_request().
>
> These two different reqsk will respond with two SYNACK packets, and since
> the generation of the seq (ISN) incorporates a timestamp, the final two
> SYNACK packets will have different seq values.
>
> The consequence is that when the Client receives and replies with an ACK
> to the earlier SYNACK packet, we will reset(RST) it.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

