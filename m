Return-Path: <netdev+bounces-178184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEDFA755BD
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 11:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C01063AF64A
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 10:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47909189F43;
	Sat, 29 Mar 2025 10:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgRDLvSA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875C1DDC5;
	Sat, 29 Mar 2025 10:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743243938; cv=none; b=txMD8JmKa8Uj62xWzpBkScppUmpi93KxLJQL9L6qkgIgbiEkfYTwyJuIyO43j5V1Yz1DaR+rlXLlbzbr7SI2VF2FbYW8VkjxIe/h1q1OkiCudRZs65AfgVctt+0OLiL+rcYQsgoMu+B4ygLaC2M+kz0los/f/hqr6ZU1jCrP0Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743243938; c=relaxed/simple;
	bh=e8KFgAuXvgMLJ56yll//Wupj/W59FsnKhUFYXFD92v8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oug/5SID2c/vh0LI844pgpEuVDu4yuqJK6dD6m2XITmyaQFgVd8I8yZ3z9qIgx6tucl9mrBrigH9wINVjzQx6k+FalY6nDhSAgZMQF/3+0Z/2lIGp0o5y8r7PsbdxCsGmugq5LtCgmJhTINGsfHvf06HKfy3FZNx2jnlPSqku0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bgRDLvSA; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e686d39ba2so1175401a12.2;
        Sat, 29 Mar 2025 03:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743243935; x=1743848735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=skdz2J8vky2zwdmsTEpeak328qCERbX3VX3swBulodM=;
        b=bgRDLvSAKFTuRqXdk1LaLp0O8kuB2BvBT/d9mOWnWRAvGHqZEVpCS2mfX3mWn0L+Ug
         HNPT5OPLCiEQ5+0EREllOlcoGkQn14yhn7XVtbvR41jiOCLG/ar18gvfux4Ioy+6iveo
         cUp68gnFEd8EfWuQp65u+EEApc1v9PFTUfuFqxNf2FxYklC+tcFv7eepmYqedL2cI60a
         bByJ85b1fYp4N9/kNPR4D+mAfi1uCsMf1PEVfsuVOj2BbC/2e/IouOeUnMI+0dDmO9kR
         RDA9pLOWYJN+96DHYBnTHYE5BCUTktM4uxKq1gh9Y10puTJLuDBBqahDetLt7awxVv2e
         Vk1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743243935; x=1743848735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=skdz2J8vky2zwdmsTEpeak328qCERbX3VX3swBulodM=;
        b=aBli25zN82++aGCyyg2qZ/5EepFbUQXsHUSWE6R375FrVUZYeFyFnR9bKlJa4diS9v
         V9Mz0zGatI4JjWzOQMts+KQkFQ++BPbUXVaZ8M1Fbvqqt/5nGgqPz0OePC6316vwCDZ9
         cSoU5RJ7Z2SWEDNeQ41WD9ie9T2lx0b34B3xehJLP1ORc/xyZkdJrnAlQCoRQLMbV15/
         5mzA5P4Hz9I4xGSKtjz8NdEDrALRfXLyyNCAFp9GC3UVHolBFQWHX0nWZYzizvfo9W69
         AqBnFXN7IBeWDPUXzg/hrdrxWdm3wQTAa861nTLulUssXX1oHOpJp0XqIOm39HqHUJwv
         0Osw==
X-Forwarded-Encrypted: i=1; AJvYcCUxB94DlSVPt3KqSsXJuCdkS4E7zgW3TtaouhDgwgNG8hkwkaQCDhTO0XnYRFZU4QLbGqF9qqOXwVKe6Do=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8oMBwwaTwxI9Jov/Iqru7Ze+n39RLi3TUrWY3FAClfcOY8iz7
	G57ObOnNhhpMrLlgfEPuZlQbKDA/SWIW7kV35lOsybqlc+TwmSWgDCScM0iDsrTyTQyMgVPqUzD
	7VVt8ko+NwAsrRrlDSu2z7PeIBl0=
X-Gm-Gg: ASbGncsziIoDy+BBObtxrG9pc8vvpctq4ZFhrIWaHFCWuyh6PEH5ktV/P6FWaqFqEkP
	jjU1eoH9++zYWt/iedj+mJmECclJlsCT2mLg0B9D70sgkckEBF16NFoy5N1+0PNp1Gvxwl6bKj+
	XCjj7la1P18UZLiO/gt8ZGYvBdZCc=
X-Google-Smtp-Source: AGHT+IH/ysz2hKHseoTKN+bQp8ZD1ck3UYjLHNFyo1DMrE4qsSXt6TBId2ymDv9u5fFo93SJET9TvhuCEN7P/zvSs3o=
X-Received: by 2002:a05:6402:278f:b0:5ec:cba6:7d82 with SMTP id
 4fb4d7f45d1cf-5edfcc1fbcdmr2118434a12.3.1743243934565; Sat, 29 Mar 2025
 03:25:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250328174216.3513079-1-sdf@fomichev.me>
In-Reply-To: <20250328174216.3513079-1-sdf@fomichev.me>
From: Taehee Yoo <ap420073@gmail.com>
Date: Sat, 29 Mar 2025 19:25:22 +0900
X-Gm-Features: AQ5f1Jq-HeWugC2XpX6jq-tfrgIkY9D9KShi2zZ13QuiHnYDaGgGvtz3y3Yu1Dc
Message-ID: <CAMArcTV5gtpfM7CXP_s506YDGC8NbSLNmwPJ_FvY_k4Ej1cojw@mail.gmail.com>
Subject: Re: [PATCH net] bnxt_en: bring back rtnl lock in bnxt_shutdown
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org, 
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 29, 2025 at 2:42=E2=80=AFAM Stanislav Fomichev <sdf@fomichev.me=
> wrote:
>

Hi Stanislav,
Thanks a lot for this fix!

> Taehee reports missing rtnl from bnxt_shutdown path:
>
> inetdev_event (./include/linux/inetdevice.h:256 net/ipv4/devinet.c:1585)
> notifier_call_chain (kernel/notifier.c:85)
> __dev_close_many (net/core/dev.c:1732 (discriminator 3))
> kernel/locking/mutex.c:713 kernel/locking/mutex.c:732)
> dev_close_many (net/core/dev.c:1786)
> netif_close (./include/linux/list.h:124 ./include/linux/list.h:215
> bnxt_shutdown (drivers/net/ethernet/broadcom/bnxt/bnxt.c:16707) bnxt_en
> pci_device_shutdown (drivers/pci/pci-driver.c:511)
> device_shutdown (drivers/base/core.c:4820)
> kernel_restart (kernel/reboot.c:271 kernel/reboot.c:285)
>
> Bring back the rtnl lock.

Tested-by: Taehee Yoo <ap420073@gmail.com>

>
> Link: https://lore.kernel.org/netdev/CAMArcTV4P8PFsc6O2tSgzRno050DzafgqkL=
A2b7t=3DFv_SY=3Dbrw@mail.gmail.com/
> Fixes: 004b5008016a ("eth: bnxt: remove most dependencies on RTNL")
> Reported-by: Taehee Yoo <ap420073@gmail.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index 934ba9425857..1a70605fad38 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -16698,6 +16698,7 @@ static void bnxt_shutdown(struct pci_dev *pdev)
>         if (!dev)
>                 return;
>
> +       rtnl_lock();
>         netdev_lock(dev);
>         bp =3D netdev_priv(dev);
>         if (!bp)
> @@ -16717,6 +16718,7 @@ static void bnxt_shutdown(struct pci_dev *pdev)
>
>  shutdown_exit:
>         netdev_unlock(dev);
> +       rtnl_unlock();
>  }
>
>  #ifdef CONFIG_PM_SLEEP
> --
> 2.48.1
>

