Return-Path: <netdev+bounces-30770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9530789056
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 23:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D75C91C2101C
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 21:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A1C193B0;
	Fri, 25 Aug 2023 21:24:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DB4174F7
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 21:24:21 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBD62126;
	Fri, 25 Aug 2023 14:24:19 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4ffa01fc987so2832285e87.1;
        Fri, 25 Aug 2023 14:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692998658; x=1693603458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAvdxGRJNm0KAatLMLcV87iYXC997rK/9oVNl8An31I=;
        b=EdMzk7VFFK7sU2Y8cOGJylYOBJtZc6DglyLy7WW2MlfE7KVNX9+kVA627Mjg2S1nuv
         /++QYreB9pzooxNgrPmLz0D4qTr4xfyetYa8o7FCBLpxku1BVIcc3G2f56qVKM5eX6vM
         OkVV40XTUyIuUNc71aE1XrLbt/Sm/1aXm/RN9AOW4ErRuPrioYpCwPfrDdmiYf9Ho15s
         DrhF8dNYjVUBZljEv4qDjIspMdNS4ZkeuV2SAd+hnzBVQ9lisOmwCHZPmNuq+xsM0ES9
         DEVQr9aSC3pkPkhcP/nrEweep1kIndWvUkb8BSX8vIewgHwIroDsnlNkugvCz9lx2WmJ
         vMtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692998658; x=1693603458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uAvdxGRJNm0KAatLMLcV87iYXC997rK/9oVNl8An31I=;
        b=ZqJIBSwN9flWPhIp/MrxZZ4DfivzmuGxv97/+gBCZIFY4HRPAqsI8dbk/xU/D+lh/c
         eFZMojh6vjG4hOcFePs41IEZhbnt7VQZCQvu9W9k7Dn+W3Zsg+nuXxY4GrpPkZjg5Pky
         CkOiT/FEa49rfmahdmL320uDu9rK+ColzxbT5NF8S9HMWAf82jvRtb7s5pZ8LKqMJY33
         ILyvqkUaPf9mTvCCKzD245puxEnmHTtLFrFMszd6ljU8OGfJNzH3KboIXhxmJlEe6K9f
         ta0kjk/7L/XE88IYv5u+lUUMMRJl9mch1YQsPlfVdoX7QV5RwdXQDZSuhlJt6o4Ss+5n
         b6/Q==
X-Gm-Message-State: AOJu0YzRbZXUPTdrmtB1XQHYRYBOIruM3pDYejujdFpxREQxrgztz7NK
	ttnPyMwXDZjInI5ajQPoHhRg6W+LGKokVAHd7bA=
X-Google-Smtp-Source: AGHT+IHEqh8MOurQUl5UbtkJsmWLglp5EXFvNEKnNoXqGh9kjzmi4K5f8CCnMUOsiOKpYf8vQe8dZwJgtyakodQk8aE=
X-Received: by 2002:a05:6512:ba7:b0:500:8676:aa7f with SMTP id
 b39-20020a0565120ba700b005008676aa7fmr5726857lfv.23.1692998657716; Fri, 25
 Aug 2023 14:24:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZOXf3JTIqhRLbn5j@gondor.apana.org.au> <E1qYl9u-006vE6-L2@formenos.hmeau.com>
In-Reply-To: <E1qYl9u-006vE6-L2@formenos.hmeau.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 25 Aug 2023 14:23:00 -0700
Message-ID: <CABBYNZKM+pHzU7_6x4_25mZ5nb-hAJWahVZh6oac+G8=9Q07Hg@mail.gmail.com>
Subject: Re: [PATCH 3/12] Bluetooth: Do not include crypto/algapi.h
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Eric Biggers <ebiggers@kernel.org>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-fscrypt@vger.kernel.org, 
	Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>, 
	Xiubo Li <xiubli@redhat.com>, Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org, 
	Steffen Klassert <steffen.klassert@secunet.com>, "David S. Miller" <davem@davemloft.net>, 
	netdev@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, 
	linux-wireless@vger.kernel.org, 
	Matthieu Baerts <matthieu.baerts@tessares.net>, Mat Martineau <martineau@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, linux-nfs@vger.kernel.org, 
	Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, Ayush Sawal <ayush.sawal@chelsio.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Herbert,

On Wed, Aug 23, 2023 at 3:32=E2=80=AFAM Herbert Xu <herbert@gondor.apana.or=
g.au> wrote:
>
> The header file crypto/algapi.h is for internal use only.  Use the
> header file crypto/utils.h instead.
>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> ---
>
>  net/bluetooth/smp.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index f1a9fc0012f0..5f2f97de295e 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -22,11 +22,10 @@
>
>  #include <linux/debugfs.h>
>  #include <linux/scatterlist.h>
> -#include <linux/crypto.h>
>  #include <crypto/aes.h>
> -#include <crypto/algapi.h>
>  #include <crypto/hash.h>
>  #include <crypto/kpp.h>
> +#include <crypto/utils.h>
>
>  #include <net/bluetooth/bluetooth.h>
>  #include <net/bluetooth/hci_core.h>

Acked-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

--=20
Luiz Augusto von Dentz

