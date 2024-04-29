Return-Path: <netdev+bounces-92242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E628B62F1
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 21:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E09AE1C21AC0
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 19:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007AF13D29C;
	Mon, 29 Apr 2024 19:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JsvB94Cz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A54613C3D3
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 19:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714420617; cv=none; b=s2hP6d+3MPbKGzKj94epdCmvJILM7rBFn/E1/lDlQ/cEMB8AAvkOtYppukTf4D8Hqmod5Lvzj0af7t/jP9FYvhDyxelvUZ2tzPjTsZWB10iMqhsvg7c/+Vy6v9rQQ7n991j/q/kZNGScvw1ds8mnLsjw/wjKDsURRlvhRr8/zZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714420617; c=relaxed/simple;
	bh=Oz/47XesLfkXt3OtQ8v9MvqsWPB9C7AkbnLE6S4xd+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxKtKGyvx7VDmnX8hmtW+e0qjBi4uPr5RNBxZNvnxVVcx2UgnTYnvfPWFm5U9QLRf9dfJN7pTYbVQO5G01S6MOb5zSLvWdiUmCXoaNcP4rQI8cfNWR1/Zz1sEC/r9R+0eQqVrVTRONUUTGFJJJV32dhsGpkyHCRI5mRW/5UfETE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JsvB94Cz; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5aa400b917dso3345924eaf.0
        for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 12:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714420615; x=1715025415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wzh3iHAkozkq9gOCrjq5RtMClk8JbO8nQV/YvwV7pkc=;
        b=JsvB94Cz6WnIh1RlkEGNxgEezpzne+ubUr/OV9Vpk062DbWJ3hkngLFckDrVlw/WVm
         ubDQpwitE4Mcg2Vq8pD5ukDd8G6G4Esz5Ujb/ElSJ5NO+4FZ74gnm//727RV4lVNercC
         MB9hVtr5/RiqrZz15WqE5FHZmnFGXXvEyjquY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714420615; x=1715025415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzh3iHAkozkq9gOCrjq5RtMClk8JbO8nQV/YvwV7pkc=;
        b=wSsVGFVhPk4tWak9lgP1weZNhZhAlcvjV2flUrAffUHSb4YKjq9hlBjKZHkgwgnvkJ
         sf59fgzD9S1mQM1RvavaUJrwbZeGfyRt6Qh0RJIJORCpDFvkn5hfDJpgfejpLy8Ji4NK
         5DDgooSPRdf1LYgR7IMKeBHV0ijKEJ/gtyo71ctiXrWtL/uN6ezxtXyKp1PhhUT37alb
         wvpVOBVG65uqpdHWjYjxA5VXoa3He93/oLVO82PRA5MqHhGHKO0ZjTiujbgCLWfp/tU+
         XDNF/uigD8o7STPDD0GHyveICmcLSn+1MS3Bbo8ERWe5SzyNmgJFLcIcWdbBSI8bMFRe
         xKqg==
X-Forwarded-Encrypted: i=1; AJvYcCVBbGuuvm1YkoxEGuA0OhKJVMsI9/QVOqNuGeEwWXjKRSdRmJrR0y/6+IWiPlCUU5Xzxk8RfohgdcsuK2WjDrrU3Ha9SHse
X-Gm-Message-State: AOJu0Ywz7GX33KoAA2eMMy35WD94A0O1NB66j81kYqEEbPMdPIfJnuk/
	95hz/7QfH9OFJi8yw946d2BLeuyhN2COxSzB8J+Y0ZTupqfszHFvLoKETtG3+g==
X-Google-Smtp-Source: AGHT+IGIIBDxgLzwela6Btq0sEBd7W1pqx3IiWnUloNQkWiaGW4i8tZehT+xlO6+NtB/zC3tsLMgMg==
X-Received: by 2002:a05:6358:3916:b0:18a:62fd:b874 with SMTP id y22-20020a056358391600b0018a62fdb874mr11846383rwd.17.1714420615575;
        Mon, 29 Apr 2024 12:56:55 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f13-20020a63380d000000b00615707f8078sm723421pga.17.2024.04.29.12.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:56:55 -0700 (PDT)
Date: Mon, 29 Apr 2024 12:56:54 -0700
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] Bluetooth: hci_conn, hci_sync: Use
 __counted_by() in multiple structs and avoid -Wfamnae warnings
Message-ID: <202404291253.106D020@keescook>
References: <ZiwwPmCvU25YzWek@neat>
 <202404291110.6159F7EA5@keescook>
 <b09450f9-c42f-41f8-a2f6-eea3515eaa2f@embeddedor.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b09450f9-c42f-41f8-a2f6-eea3515eaa2f@embeddedor.com>

On Mon, Apr 29, 2024 at 01:50:46PM -0600, Gustavo A. R. Silva wrote:
> 
> > > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > > index fe23e862921d..c4c6b8810701 100644
> > > --- a/include/net/bluetooth/hci.h
> > > +++ b/include/net/bluetooth/hci.h
> > > @@ -2026,7 +2026,7 @@ struct hci_cp_le_set_ext_adv_data {
> > >   	__u8  operation;
> > >   	__u8  frag_pref;
> > >   	__u8  length;
> > > -	__u8  data[];
> > > +	__u8  data[] __counted_by(length);
> > >   } __packed;
> > 
> > I noticed some of the other structs here aren't flexible arrays, so it
> > made me go take a look at these ones. I see that the only user of struct
> > hci_cp_le_set_ext_adv_data uses a fixed-size array:
> > 
> >          struct {
> >                  struct hci_cp_le_set_ext_adv_data cp;
> >                  u8 data[HCI_MAX_EXT_AD_LENGTH];
> >          } pdu;
> > 
> > Let's just change this from a flex array to a fixed-size array?
> 
> mmh... not sure about this. It would basically mean reverting this commit:
> 
> c9ed0a707730 ("Bluetooth: Fix Set Extended (Scan Response) Data")

That change doesn't seem to need to make them flex arrays, though --
there's no savings at all (the same amount is stack allocated).

Anyway, not a big deal, I guess. It's an improvement to be using
__counted_by, so good! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

