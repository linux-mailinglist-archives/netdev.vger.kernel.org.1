Return-Path: <netdev+bounces-85658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0A089BC6B
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 11:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA9A3B21E82
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 09:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EFA4EB43;
	Mon,  8 Apr 2024 09:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h4Dyzskj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3D34E1CA
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 09:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712570169; cv=none; b=m0EBrAB+d2kBg43y+V1fx7FlSkSjCUo3K+ZA25I0YSg530nIW/gc+0/GnM212NoUJnw80UgH4k5OwWZW8CsBFCXGDhIPiGOJTK3Jnx0BK0DIordTahBekR4XuwVpqRVloYPG18tdh4ToWKEcLRtGPxNbj3TC4kJ/gwKvSpM6eFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712570169; c=relaxed/simple;
	bh=LwyvMM/osJwH6vJPmU4ZO2uCiOeVzGUiiHNqjIKfpJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UYuf/YiV0oa8nyTh/mTvxPrrXLh2Wihspk9QgyM7CrRMZMN1K4czFBPkHVSSRXJwEOllIcyOkpDQUnfNZGC0gCTmUWTBJAHVpTQyhFIwcNGjcZVTGfN5CnpIEF+t9oQdsGRcVlTyVQ5NJpDlZI+j2l4qDo+0veeI35pnUHeeGYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h4Dyzskj; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56e5174ffc2so7260a12.1
        for <netdev@vger.kernel.org>; Mon, 08 Apr 2024 02:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712570166; x=1713174966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NBLlpBXDu8VTMGb4M7KQYnrZBt176tELNst411LxfI=;
        b=h4DyzskjeqyNDor3BayhZbsEIlgTDmEw4jidjv/vi3IEVKrFIUGWor2I7VYTc9O4kf
         Ey/WTu3YOd2eElxZXDzb6R+q8gFaXH77wiX6pf+eMJuiKPJ+kxgWnSuAdGG7hVVCVVgo
         fWkKsvx/pY9vhsjt3kaBSUZ8NGylWJGUfPa/+zjXcs5Uq3n6D73D8WNfCGIHbnx7o7tj
         mWzxNjIGSRa0mPKuNbxaziNAKTM14o4igFfkORjxBxzZeo2VCaFN5wbttjyedm1+cWCx
         sCBhZBvyuUGJflPa8PN10A2494KkGyCRYFk7gVxwUQQMQB56JGyWHvIaTR0IA0uw/oK2
         PEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712570166; x=1713174966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5NBLlpBXDu8VTMGb4M7KQYnrZBt176tELNst411LxfI=;
        b=XMcNbea6aJAza70nih8kcgUshI2lL/CH9mSPeOxeiHIkw0nKdzkU44ljEvGxiOA00O
         M4Kg2WGUpQzDuVWzGNEfyG5MweL+h378UfhC2MTNMoLbLbJiuYTFQ8Iz+FnY6bUHtWii
         uDeg7YSUK7TV8s0TcJqxcEOu7z4wJjggYZ/3t/RkY9EPA8ULu+R9PzKlHKthM3+UsQfl
         YsFUoKStJZX0hIC40DLMh7SS8uDD0Eq5CCJbPi5BQqB5lyPEFousCYkQiQsholZ68NcU
         U5MmAu9y04nV3PDRUYqI3XFW2M/Y4D7nQP9vB6JCJm1wCoV7ZcivPEfjfjeRGH+f4rJZ
         3WnA==
X-Forwarded-Encrypted: i=1; AJvYcCXNfN6TQOpiIh27MTnPg/BQ+SKI2W7OKrL311jq7MOOHWTsoWMkg6BqtFbTvrHi6OYbBEEtQC25TyIfBQJ0hcBSwW0z9f//
X-Gm-Message-State: AOJu0YwfDAa3G+T017hHZtyiYQ2qREup/pAduwavW/qXFJbJiCoKG1/o
	o2iZm4PCJfF2ygvBeZD6DFIbwethYyd8g/sCQy/09NR8bDvy4dAlljHe/Df3S+BI0zDxqr6OkVJ
	4KEa0XUBDvKVH2t2FNMRcjUSJJz+KnABx//T5
X-Google-Smtp-Source: AGHT+IE2qUojADKYdZJqeft3RAdXwSfc5OVrWJTQOnEo9gh9I4EVlEFyGGCO3ijZKUTup4SuuVnvMf9PS8JbxJKUuiU=
X-Received: by 2002:a05:6402:3125:b0:56e:556b:c3fd with SMTP id
 dd5-20020a056402312500b0056e556bc3fdmr120190edb.3.1712570165564; Mon, 08 Apr
 2024 02:56:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZhJTu7qmOtTs9u2c@zeus>
In-Reply-To: <ZhJTu7qmOtTs9u2c@zeus>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 8 Apr 2024 11:55:54 +0200
Message-ID: <CANn89iJrQevxPFLCj2P=U+XSisYD0jqrUQpa=zWMXTjj5+RriA@mail.gmail.com>
Subject: Re: [PATCH net] nfc: nci: Fix uninit-value in nci_rx_work
To: Ryosuke Yasuoka <ryasuoka@redhat.com>
Cc: krzysztof.kozlowski@linaro.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syoshida@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 7, 2024 at 10:05=E2=80=AFAM Ryosuke Yasuoka <ryasuoka@redhat.co=
m> wrote:
>
> syzbot reported the following uninit-value access issue [1]
>
> nci_rx_work() parses received packet from ndev->rx_q. It should be
> checked skb->len is non-zero to verify if it is valid before processing
> the packet. If skb->len is zero but skb->data is not, such packet is
> invalid and should be silently discarded.
>
> Fixes: d24b03535e5e ("nfc: nci: Fix uninit-value in nci_dev_up and nci_nt=
f_packet")
> Reported-and-tested-by: syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail=
.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dd7b4dc6cd50410152534 [1=
]
> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> ---
>  net/nfc/nci/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
> index 0d26c8ec9993..b7a020484131 100644
> --- a/net/nfc/nci/core.c
> +++ b/net/nfc/nci/core.c
> @@ -1516,7 +1516,7 @@ static void nci_rx_work(struct work_struct *work)
>                 nfc_send_to_raw_sock(ndev->nfc_dev, skb,
>                                      RAW_PAYLOAD_NCI, NFC_DIRECTION_RX);
>
> -               if (!nci_plen(skb->data)) {
> +               if (!skb->len || !nci_plen(skb->data)) {

#define nci_plen(hdr)           (__u8)((hdr)[2])

So your patch will not help if skb->len is 1 or 2.

