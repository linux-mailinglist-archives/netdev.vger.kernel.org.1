Return-Path: <netdev+bounces-84988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD9D898DD6
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 20:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE6331C2764C
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 18:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A9F1304A8;
	Thu,  4 Apr 2024 18:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="ZoXjvpzB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC06F12FF9B
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 18:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712254692; cv=none; b=fbexQhyscZZggQPYZOQpg+zN5p9RtPpRhUeuW4u1zFwcKS186cnF2K2fMlGIhb3ZDF+oZvUjisBzrLdkGmr/Ex8Sx0Vqhcpymx6RCdRrV2K4430WMfEpBw0jdXNvOBKhqvr/pCxgjtYV7OXqqGveDjKhFBzw5SgfirQu1pfm1gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712254692; c=relaxed/simple;
	bh=SNfX+q1IgkQj9nz0GckYsepusnw34MhTeimF85l/VUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iKoNUf+OTCGDl3rFNnJFClzvMvijJKvJddaEFUePT2+w2Zz5MvRghDwNA2in9ysaqtXAllN3Zsnt503uuSjQ/UGylF6q4VduZ1HaYlQRmygQHxveOjbOZDg0+QkmOYoFaEVE+isQm91OcbvUzS0xd6Cfb6xzZpqNbKFHct0d3qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=ZoXjvpzB; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a517d773844so189097766b.1
        for <netdev@vger.kernel.org>; Thu, 04 Apr 2024 11:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1712254688; x=1712859488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNfX+q1IgkQj9nz0GckYsepusnw34MhTeimF85l/VUU=;
        b=ZoXjvpzB9O8q4mfd/1iHNRmoPQzRmvOm5UrT/TbbrdDvZid338252P+r5DtUe2ivVE
         bFczjWVKzvxbSSgrP+bK9fIIwS5AWyxOgGpctra+EuVcgnkNsE0v3amei6rcvlFXeuRO
         G6Qw3Gz780oyiUl5zx82bVklcEc7YsLgHipDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712254688; x=1712859488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SNfX+q1IgkQj9nz0GckYsepusnw34MhTeimF85l/VUU=;
        b=CZThjrEmVgKotF93Ta6GlvTnRQclBy/rI0Ek7RxjfQ8ieb/IarRRnAsagFx6SQ2EQS
         l8ufthHKujhBRYA6XogEDfGP5prJD9vnIunla3yeu3USWxOKFoyNV67uNFxTHTcSYDG0
         sm/PSc0AjR7AN/HQcp+K5JitxIdLFY2rSdcBjMkXQXKeCGULPk8DDwtlfLXSIIfS+5Q/
         X73tEdbXMwO5jKfakTcvODOTRqym0MfbmZxhs3Tvp+EkqFdoc3lHxBCMibf0KxIXKoef
         tBlxpNuPViPizKa2NgjWiuCCR3UD3AGLCMw6NxtXbPU4SLRuBIO0ozF0HjK0NirDA5aA
         kPgQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0MuWv0VazyGuLLegItKVXdRZ/5Mthjkz5Ep8w2cpC6sF7SZfbkBHeVOjgZLL0S3kPWX4pRijtBh9Fcdc8GgiUwfxhoSek
X-Gm-Message-State: AOJu0YwClqzKzM19TEf6wmB9pZ2woIVGKwgvUZEG1dHm4kkrByUZdQX9
	WwHYbV7UMDvHx+HXGHpgetwnSH2IFcxQw47aeZcrEd/tYgXLvpp/vdXAqto5soqJzZ9npTqP06Z
	huYHQqRGtr6WwK28AG3p697sQcf6tAIUIU2zL
X-Google-Smtp-Source: AGHT+IFs1ZK7fW9vhtx+DT4doL6b7bsFLXc6+FeNlebBKgAPxl18h2/KgaTIEGprqn2OnYYpU3mldzZYNuXXB6RyHE0=
X-Received: by 2002:a17:906:d0d6:b0:a4e:62b3:6264 with SMTP id
 bq22-20020a170906d0d600b00a4e62b36264mr271865ejb.76.1712254688003; Thu, 04
 Apr 2024 11:18:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+9S74hbTMxckB=HgRiqL6b8ChZMQfJ6-K9y_GQ0ZDiWkev_vA@mail.gmail.com>
 <20240319131207.GB1096131@fedora> <CA+9S74jMBbgrxaH2Nit50uDQsHES+e+VHnOXkxnq2TrUFtAQRA@mail.gmail.com>
 <CACGkMEvX2R+wKcH5V45Yd6CkgGhADVbpvfmWsHducN2zCS=OKw@mail.gmail.com>
 <CA+9S74g5fR=hBxWk1U2TyvW1uPmU3XgJnjw4Owov8LNwLiiOZw@mail.gmail.com>
 <CACGkMEt4MbyDgdqDGUqQ+0gV-1kmp6CWASDgwMpZnRU8dfPd2Q@mail.gmail.com>
 <CA+9S74hUt_aZCrgN3Yx9Y2OZtwHNan7gmbBa1TzBafW6=YLULQ@mail.gmail.com>
 <CA+9S74ia-vUag2QMo6zFL7r+wZyOZVmcpe317RdMbK-rpomn+Q@mail.gmail.com>
 <CA+9S74hs_1Ft9iyXOPU_vF_EFKuoG8LjDpSna0QSPMFnMywd_g@mail.gmail.com>
 <CACGkMEvHiAN7X_QBgihWX6zzEUOxhrV2Nqg1arw1sfYy2A5K0g@mail.gmail.com>
 <CAK8fFZ6P6e+6V6NUkc-H5SdkXqgHdZ-GEMEPp4hKZSJVaGbBYQ@mail.gmail.com> <20240404063737.7b6e3843@kernel.org>
In-Reply-To: <20240404063737.7b6e3843@kernel.org>
From: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Date: Thu, 4 Apr 2024 20:17:42 +0200
Message-ID: <CAK8fFZ5LHFMPAOFCKu-vr7JQJHKo9jshrgvCCP50d596nFiXUQ@mail.gmail.com>
Subject: Re: REGRESSION: RIP: 0010:skb_release_data+0xb8/0x1e0 in vhost/tun
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, Igor Raits <igor@gooddata.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 4. 4. 2024 v 15:37 odes=C3=ADlatel Jakub Kicinski <kuba@kernel.org>=
 napsal:
>
> On Thu, 4 Apr 2024 07:42:45 +0200 Jaroslav Pulchart wrote:
> > We do not have much progress
>
> Random thought - do you have KFENCE enabled?
> It's sufficiently low overhead to run in production and maybe it could
> help catch the bug? You also hit some inexplicable bug in the Intel
> driver, IIRC, there may be something odd going on.. (it's not all
> happening on a single machine, right?)

We have KFENCE enabled.

Issue was observed at multiple servers. It is not a problem to reproduce it
everywhere where we deploy Loki service. The trigger is: I click
once/twice "run query" (LogQL) button by Grafana UI. the Loki is
starting to load data from the minio cluster at a speed of ~2GB/s and
almost immediately it crashes.

The Intel ICE driver is in my suspicion as well, it will not be for
the first time when we are hitting some bugs there. I will try one
testing server where we have different NIC vendor later.

