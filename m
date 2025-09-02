Return-Path: <netdev+bounces-219244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC207B40AA5
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 18:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A5554802C9
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 16:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25F033CEA3;
	Tue,  2 Sep 2025 16:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="AtemeozV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02EF334376
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 16:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756830660; cv=none; b=HxexURW+NfGBpJji04m9hsPnGVInJl02Wlk0EbZnVgJu1bZGd8AOqExXqR2o2htCP/i3C/bKD4th9rDr1Ku2u7Uj3lzLivOtNRzJ+Cpc7vN4ns9bKSHQ0yhJOhlqcxJwpVP8JrKEv0hVBAJhOyVrghzAwmrwp/32qpuXgy3toN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756830660; c=relaxed/simple;
	bh=ARoLZXERdB/aZyOgVzhxxJVRiL6oqZtJT/TLCTB0tUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NghNA0dNSjUxXR7qE+mTbSsau/Jral/lIwgIlWgOW0WKW3AYeB3HaiBJeupTpiAJSL2X8F36kT7ECLCJWIrtB3gLyLF4kVimZLgM2i3yiGtWPzpS5aOhoxRg8SYinsf9MGY9lGJms1LmcxX3xGJ0yT7+WNH7zMQ3EWt+QUWz6kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=AtemeozV; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-337f6cdaf2cso7028731fa.2
        for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 09:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1756830657; x=1757435457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MB11qWoSG55ssqg9L7jWSrZS/svWEW6aXYtvrwkQCkU=;
        b=AtemeozVsARKSX6AShZYiYm8HHSfJylgOnSsgMkc8UKukzxpe3SJRcmAuxRgC3AIA2
         J95QHIGGeFaCK1BOfTqUq+Aq5tapPlIukXbOXvw21ISHeGJj8Eo+OfdarolPlwDfKzl5
         DXZadv0n+82qWpLXqIvw6tcZ0HoiDbl3zl9KU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756830657; x=1757435457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MB11qWoSG55ssqg9L7jWSrZS/svWEW6aXYtvrwkQCkU=;
        b=tooKdKRcC7yb1qwY+4dduA5aJKQMT++dMxoc04tFUKqz2Kg+V83d6hI51wCBEzOuKO
         GxjCHDbhAmOkUm01aY030HpZXaXW4M9wkx3Vme4MVnG9GdbaV7xXosfhxsp3yZuc48hq
         LMs6WWposRI9QvLyMftuYFjiO8S7m/NsgDWfZ6hfXNg+2P+XMtCD9eGZb47LIHpIzULE
         TlQaNJO96qSl3GNeAdBZSpukgdWG+Q7apl/GAB/v66d1dl2QXP2UnYG/zeCnVpp2k8qj
         4dXRvvHCHqq0kN8wCyQAVmHPYGcEqAqhuvr/vx9+CCgMqOAPZW+12/BdWmxXvTYjqKoq
         feQA==
X-Forwarded-Encrypted: i=1; AJvYcCXNPpk9YgNjiceCzkg8xSX3JowMBYc+koo9EWd9X62CXDLJnBAGIdR3WjQAh8+9hVtgJQIgpZw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6n+D7TfUIwKTi4/MULjQq3zoEwg343A3HYCSErESO0oHMfRnY
	v5aFCM8ibS5yE5++MJv0G5ggdox+Qtw3TsrvNLA0u5AOv14eXCElRXHyFbcIzTMIx1/F/2BeEJ0
	XxYCrxGeBU2dNtBuFEXLwq7J/kCPNW1/miHIuh/1fcQ==
X-Gm-Gg: ASbGncsWDXFecJgF/P4RAR4ANhkryCtOM1rdVMdPiigrqXGrlv+flMzzm07VTjLD4MA
	m8amPCHlMSEsF/JLUjDSrOjH8f7EDh7lh8V/xJJ+fB6Mpe4v421elGTt4EST7M4tgqfbsscAHFc
	YhDAFe85Atp9viLem14H5c/eXXIB11dv0/sCivuN9C9Xlj7Xg7DYldN7dhV39KCfUyKzSAVe3Ws
	S7qTkIH7dyekvp9BNv+pXrak8szuLm9Odwb5NGevohHY/KYYrC7N21iErmvvTwoeQ==
X-Google-Smtp-Source: AGHT+IEY1emCS4KLy2sUFVVtxJL75GD2C2A2GUQWvQJS8Zc/fUeZh1ps3yYw2O7b/xss9wIr7NLvyq/eA/SlDgeyMKQ=
X-Received: by 2002:a2e:bea4:0:b0:336:de55:9d9e with SMTP id
 38308e7fff4ca-336de55ab28mr32198131fa.20.1756830656990; Tue, 02 Sep 2025
 09:30:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v4-0-bfcd5033a77c@openai.com>
 <aLIs_-lDKHCLTrTy@x130> <e0786dbc-4681-4bee-a54a-e58c1b9b7557@gmail.com>
 <CADg4-L8+c+kHHzJhEaxKoNowbONqfMPVuqyOw7_DqhKFqzzLFw@mail.gmail.com> <aLcYO4kWn1nMnEJp@x130>
In-Reply-To: <aLcYO4kWn1nMnEJp@x130>
From: Christoph Paasch <cpaasch@openai.com>
Date: Tue, 2 Sep 2025 09:30:45 -0700
X-Gm-Features: Ac12FXxmaa2ONu42q8m48UuJA8eyWlqEwJ8-fPl1sFkNxAlFPde701qIWwwhBRg
Message-ID: <CADg4-L-irVisgCA46sXkaoqH+XKZX+b0nEmcp8HMFr30XV32Kg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/2] net/mlx5: Avoid payload in skb's linear
 part for better GRO-processing
To: Saeed Mahameed <saeed@kernel.org>
Cc: Tariq Toukan <ttoukan.linux@gmail.com>, Gal Pressman <gal@nvidia.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 9:15=E2=80=AFAM Saeed Mahameed <saeed@kernel.org> wr=
ote:
>
> On 02 Sep 08:51, Christoph Paasch wrote:
> >Hello Tariq,
> >
> >On Sun, Aug 31, 2025 at 2:28=E2=80=AFAM Tariq Toukan <ttoukan.linux@gmai=
l.com> wrote:
> >>
> >>
> >>
> >> On 30/08/2025 1:43, Saeed Mahameed wrote:
> >> > On 28 Aug 20:36, Christoph Paasch via B4 Relay wrote:
> >> >> When LRO is enabled on the MLX, mlx5e_skb_from_cqe_mpwrq_nonlinear
> >> >> copies parts of the payload to the linear part of the skb.
> >> >>
> >> >> This triggers suboptimal processing in GRO, causing slow throughput=
,...
> >> >>
> >> >> This patch series addresses this by using eth_get_headlen to comput=
e the
> >> >> size of the protocol headers and only copy those bits. This results=
 in
> >> >> a significant throughput improvement (detailled results in the spec=
ific
> >> >> patch).
> >> >>
> >> >> Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> >> >
> >> > LGTM, I would love to take this to net-next-mlx5 and submit it back =
to
> >> > netdev after regression testing if that's ok? Christoph? Anyway I wi=
ll
> >> > wait for Jakub to mark this as "awaiting-upstream" or if he
> >> > applies it directly then fine.
> >> >
> >> >
> >> >
> >>
> >> Hi,
> >>
> >> I recall trying out similar approach internally a few years ago.
> >>
> >> eth_get_headlen() function didn't work properly for non-Eth frames
> >> (ipoib). I believe this is still the case.
> >>
> >> Extra care is needed for the ipoib flow, which I assume gets broken he=
re.
> >
> >Are you actually sure that ipoib goes through
> >mlx5e_skb_from_cqe_mpwrq_nonlinear() ? Because, as far as I can see,
> >IPoIB disables striding in mlx5i_build_nic_params().
> >
> >It's rather mlx5e_skb_from_cqe_nonlinear() that handles both, ethernet
> >and ipoib.
> >
> correct,
>
> const struct mlx5e_rx_handlers mlx5i_rx_handlers =3D {
>         .handle_rx_cqe       =3D mlx5i_handle_rx_cqe,
>         .handle_rx_cqe_mpwqe =3D NULL, /* Not supported */
> };
>
> I see that the patches are "awaiting-upstream" so I applied it to our int=
ernal
> queue, will let you know if we find any issues, otherwise, will repost as
> part of our upcoming submissions.

Sounds good! Thanks, Saeed!

Christoph

