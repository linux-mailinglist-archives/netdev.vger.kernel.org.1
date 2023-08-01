Return-Path: <netdev+bounces-23401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A7576BCAA
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 20:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BF53281BFB
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 18:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832D623585;
	Tue,  1 Aug 2023 18:42:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBE14DC89
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 18:42:06 +0000 (UTC)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EA0273B
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 11:41:47 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d09ba80fbcaso6193097276.2
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 11:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1690915306; x=1691520106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIlApo8gjLRu+n0OPtD703y80JbGFniI/Qh6BfEYFQE=;
        b=ej/+U9hwE1/sqD4uxI3Vrq/mjsbnpCW+r/5zU8P/9Q67msFDNMuVHcPCiQMbx0U1ql
         UT8UINsqSzAtSGzGoMhoD6xifQQu2dhz3CZJKInQm2lv77QUPoX3FwqHM6c1OEZpJ+SM
         PGS6qpg5sY+vwd5siWngU62giao4UsJvtn1DSg8lCtrOzaBM7A8aPSTwbuYeIYS6EhfX
         Vv4YuzMBI/1IxOyvIqWTS9CLsE/Qrq4DE+5JMTTuIGbxrkB4hsZ5u59qqXznnXRXpVfk
         WfylV7egkTPkN+FHj297NJlN8BgbBGp0JJ9Twejzzs1eaARLlsh6hAIlQBhC7ASH5EJi
         2QmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690915306; x=1691520106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AIlApo8gjLRu+n0OPtD703y80JbGFniI/Qh6BfEYFQE=;
        b=c679aR/U622RLrYaRKxkHclmEk4vFh0N1mpV6B9SUexYIW9Out3OddEk4FV4iakgIP
         QbL+OpK8HqevEMB0IwFaeBiCjQgSfuMpzsepJitiHh/36X7dikYiemDGCqVa2vdFx2PI
         nBvXjUIetxWfSjfKKTuztwKm85nI8wbdKXC3osFUS+qDorYJSORQrENPpCrDic6VOE0C
         MU4HRt7fyNOChARlkEK2hjQJpgKRhTqguQn6szz1GyfKl8YHfhza9lVfkEYyJkUn7sCu
         aVt4T/NfXVhmmbqGn09bZLM8vRKcAOAByhfNonwdHuBZniGmUdoFm0KuZlF4RKsF5IdJ
         SPOg==
X-Gm-Message-State: ABy/qLZAEWebL2UoPI4rLd4sM2WpeFZARyENHzJDvKtSh4vq8d8w1civ
	bPXe5ZFMXjNpxrCMyAwMTeRyo1BGU2Hkk5UcX3jv
X-Google-Smtp-Source: APBJJlE+Rwd1XlV3i58OIr9LAjIvAndfko6lcSQsnNtJ4oRPNOp6I0MRiDn+amG/23Rsq2ThgvrK5L6Lw6R8SCNvN/I=
X-Received: by 2002:a25:dfd1:0:b0:d15:b12d:6672 with SMTP id
 w200-20020a25dfd1000000b00d15b12d6672mr12602555ybg.40.1690915306187; Tue, 01
 Aug 2023 11:41:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230801114214.2e169762@canb.auug.org.au>
In-Reply-To: <20230801114214.2e169762@canb.auug.org.au>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 1 Aug 2023 14:41:35 -0400
Message-ID: <CAHC9VhSgHdLV+b=aMwuM1qiHg2uD_Bahs4=tuVnTvyHXAA2yFw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the security tree with the net-next tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Networking <netdev@vger.kernel.org>, 
	Guillaume Nault <gnault@redhat.com>, Khadija Kamran <kamrankhadijadj@gmail.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 31, 2023 at 9:42=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the security tree got a conflict in:
>
>   security/security.c
>
> between commit:
>
>   5b52ad34f948 ("security: Constify sk in the sk_getsecid hook.")
>
> from the net-next tree and commit:
>
>   bd1f5934e460 ("lsm: add comment block for security_sk_classify_flow LSM=
 hook")
>
> from the security tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> --
> Cheers,
> Stephen Rothwell
>
> diff --cc security/security.c
> index 2dfc7b9f6ed9,9177fd0968bd..000000000000
> --- a/security/security.c
> +++ b/security/security.c
> @@@ -4396,7 -4421,14 +4421,14 @@@ void security_sk_clone(const struct soc
>   }
>   EXPORT_SYMBOL(security_sk_clone);
>
> + /**
> +  * security_sk_classify_flow() - Set a flow's secid based on socket
> +  * @sk: original socket
> +  * @flic: target flow
> +  *
> +  * Set the target flow's secid to socket's secid.
> +  */
>  -void security_sk_classify_flow(struct sock *sk, struct flowi_common *fl=
ic)
>  +void security_sk_classify_flow(const struct sock *sk, struct flowi_comm=
on *flic)
>   {
>         call_void_hook(sk_getsecid, sk, &flic->flowic_secid);
>   }

Thanks Stephen, it's obviously a trivial fixup, but it looks correct to me.

--=20
paul-moore.com

