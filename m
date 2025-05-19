Return-Path: <netdev+bounces-191592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F19ABC5B0
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 19:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AA887A1C89
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 17:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC68288C24;
	Mon, 19 May 2025 17:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cuUXCyV6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0645527979D
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 17:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747675982; cv=none; b=twCZV+xiDupBqz0Ci9Ry3MKhBgxDHihHSiyUACz+lNIvxeo71WPAo4DULnOim1e1eAOA/nKNaTAyd69mT/25CrAxtQ9n6v2YKquFp0RjkKmUBEMD9+ygM+nGWzQdK1vPW+1M+IXzaHOepbQuFgnXk3PwqGNR3QfTzvIJMf43wdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747675982; c=relaxed/simple;
	bh=f4dgfRMtTYcBFr3isa3AuROYQqzp0vO9ur0rnexY61Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z8XKKcMjsHmpXL0dESxnfVonZr03VDD421S5pG4NRpASnT1Y9hJvEov7Xk7WdIGp/rrS2zApdPvjoznceQOLV6nEtkmpUu3SZVMIbV9YP1KOb/Ef7zXkqs/L9zcOWhVELNq4mabXbEVK8OEXst5MSEi4QxtbgHt1yABG1HT1lFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cuUXCyV6; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-231f37e114eso477815ad.1
        for <netdev@vger.kernel.org>; Mon, 19 May 2025 10:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747675980; x=1748280780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1tcAaZdGQpMjictMPYKyIxyCcVwEKuNN7fh7v7Ym22Y=;
        b=cuUXCyV6qGzXDJwr8AmMAaz21olJquI5M1uyQ1f/7A7gm2nPUPCkNbQh3LwpF11oXE
         FCLsEvNJUG4BLkE+1rjLBOPdjVNGnPUK2dt441bVCKd1PKCCjWelKMUkdORNDsEWP+6z
         gsIJzRaMFoKsiNzVbCe6LFye2nbqA5F9FfkpA646R2Kw5vOiXoJs6l0BJpe10imC0Jpb
         kweDtqVoGP59O+aS992VPEeDsu+lFwwlaAEq5Ol2RTV4LycyRC3sc86uRobpWh86V2o1
         h14JIig+QVjyuB95w0blVG0XSATEBKoj7EnvL4aj+w3NNLudUoJhL8A/a/vueZQbCwg4
         ZjtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747675980; x=1748280780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1tcAaZdGQpMjictMPYKyIxyCcVwEKuNN7fh7v7Ym22Y=;
        b=T6A4foF39Ej2wMfTbwqoRUGsBEv1RvvwjbloaUTkYN7DA/ng4htHIqx7jVI5KRjn1i
         HAQtJZPAq2EY+jJyD3LWs1eN110gyc6WAsSJ7Fr4QEZrbKAFcToxXgbbyaTBat9Vhfky
         zlVQJJXH+YKOeo8i8IAtYRmMaQnPZUqvM11ijF5w+H88dOjEXZri7VdC7j8Eoh9NV3LX
         JR7QPRUh78wEuNNEcAanAclhouPfgXl0yr+rfn+R+ThJiWDh95BZ416lqqGAjVcu1KDi
         yZISnsvagCJRzAsfsLAHZ6bqE0NezQmw3PgMTiDuYi9vSZgCZSdNJ31/kv6LtcOUxAKG
         rEWA==
X-Gm-Message-State: AOJu0YxLIPCG0VbkomDlKZ0lXItkdasypEEPOvURfFdBJIjsihGYl6/b
	H+7i4w1OuA1/tbc78Nl6cbPqggA087tkDoFCA0ZuWEs+NMytGMNu2fpb+dgOP31D0hDwfZNQSdU
	A3AP/Aac/G796bER2DsJIYEydP6hHWp41Uec+eNxR
X-Gm-Gg: ASbGnctYE0lNQF8KuX+na4x2a2+jPVmZHqyCLRzBWyF4jfSTnes0Z9OLcWVCk7VU4qQ
	bEij2yu81IItDi2V0+xxXuGKQjr/PWwJXnUoSp/M8197cRviSXD0kO0flP03Q4MGYTrZ9kE/zkx
	dd1tBv7Imk8c8ZpQpD9AX6dl/rsdn9v5Yq/O5PY1rodCtW
X-Google-Smtp-Source: AGHT+IGs+elfCZbGySGmARwysKiN5p4pA5ucWH3hrD3Nt/Z1HRaqMpOBAmn2/ArPLy46knYKJuvBPtRwFmnKGvjEYGw=
X-Received: by 2002:a17:902:d48c:b0:22e:766f:d66e with SMTP id
 d9443c01a7336-231ffd1ac56mr5590675ad.12.1747675979944; Mon, 19 May 2025
 10:32:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519023517.4062941-1-almasrymina@google.com>
 <20250519023517.4062941-8-almasrymina@google.com> <aCtQIK-vFm6j6o9w@mini-arch>
In-Reply-To: <aCtQIK-vFm6j6o9w@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 19 May 2025 10:32:47 -0700
X-Gm-Features: AX0GCFt0iOE7Rccr5An255yF4CJvW76_sgtAE7JjibiHwryZmUnfjp-kmbjPgrI
Message-ID: <CAHS8izOKZBtDQT7zjd81v8X5sAXB0NAsL8iXYg3_0zurwF1WhA@mail.gmail.com>
Subject: Re: [PATCH net-next v1 7/9] net: devmem: ksft: add 5 tuple FS support
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, David Ahern <dsahern@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, 
	ap420073@gmail.com, praan@google.com, shivajikant@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 8:37=E2=80=AFAM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 05/19, Mina Almasry wrote:
> > ncdevmem supports drivers that are limited to either 3-tuple or 5-tuple
> > FS support, but the ksft is currently 3-tuple only. Support drivers tha=
t
> > have 5-tuple FS supported by adding a ksft arg.
> >
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> >
> > ---
> >  .../testing/selftests/drivers/net/hw/devmem.py  | 17 +++++++++++++++--
> >  1 file changed, 15 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/t=
esting/selftests/drivers/net/hw/devmem.py
> > index 39b5241463aa..40fe5b525d51 100755
> > --- a/tools/testing/selftests/drivers/net/hw/devmem.py
> > +++ b/tools/testing/selftests/drivers/net/hw/devmem.py
> > @@ -21,14 +21,27 @@ def require_devmem(cfg):
> >  def check_rx(cfg, ipver) -> None:
> >      require_devmem(cfg)
> >
> > +    fs_5_tuple =3D False
> > +    if "FLOW_STEERING_5_TUPLE" in cfg.env:
> > +        fs_5_tuple =3D cfg.env["FLOW_STEERING_5_TUPLE"]
>
> I wonder if we can transparently handle it in ncdevmem: if -c is passed,
> try installing 3-tuple rule, and if it fails, try 5-tuple one. This
> should work without any user input / extra environment variable.
>

This seems like a good idea, yes, but I think install a 5-tuple one
first, and if that fails, try a 3-tuple one? 5-tuple rules are more
specific and should take precedence when the driver supports both. It
doesn't really matter but the 3-tuple one can match unintended flows.

--=20
Thanks,
Mina

