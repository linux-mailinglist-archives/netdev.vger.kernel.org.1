Return-Path: <netdev+bounces-53075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7D68012FF
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 19:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A33661F20FB2
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 18:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080474EB4D;
	Fri,  1 Dec 2023 18:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="w5CnI0Nl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4991724
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 10:45:59 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so891839276.1
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 10:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701456359; x=1702061159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hezC5eRq5W8NhfmGtqzQbQvBPdr5rJpGs9ChEAna4Sw=;
        b=w5CnI0NlF6MYICKbYih+tnMemE5bSeq24lscXv3wowdNECtyTyucacCLIgSB8dVqMw
         b8KTyfbEixPTz0nw7pNum2j2VTNAhXTi6z5CYeYL6oxfWOIllQVKtUwjWu3FoABReFmh
         /xo5rfWtXaluHq3JVvEABaCFkld34oV0Wvl/2c30SkebeHbGbKe5s7yH0Y48SBGXzARv
         RkATAhrYlzD56D5YkkoDQHs5KcUCpxqERfvfIDs+HWF0z+dzRM2JtHcw3XE7SJ1Hk2Q2
         DH3cpQYaxg+3wu3iGcC3+VjsM1hB8MvcvtyVnDU7iNMyABqturls1cnRh7Q2VoJPTdOt
         T52w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701456359; x=1702061159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hezC5eRq5W8NhfmGtqzQbQvBPdr5rJpGs9ChEAna4Sw=;
        b=EJVyO0MOo54Kqt+XIAx/lcPL6DU7AnxbNPeVbr6zfenafsjRNZpgZeSCG0BWOqfsbd
         yTEehRiRd0Dba5rOFgNSVItWzPk7p1X+Fy3+cCZ98RrJ16oAmsATsRch0yQHj2a+qNZy
         dWhhPiQS35pzFPPObElwevBC3Aq6FIWarwM0KO2bsH+bATDPyt9HtXrJxOcewif+Cy9S
         hJbYyY4PoYByKSiJK8iv+TgUP6dxuw2XrAHu2jmMkAlsknpp/LRkXOEk1YC55UGuzjsv
         Pmex/x/SHqF9jUTFyt1JoI7lEitekoSenlaHUG1uJNouB7iOCI3746Qkcj5aLAG7Pr0c
         pSKg==
X-Gm-Message-State: AOJu0Yw7juWcLZoV+pNFGQX5otHWSgGJXOcRarraF3CYhr4ydaZnyBPA
	9/4GQfPLlsSrwPA+Xd/3aJvus+srZk2GPsfBEVpZYw==
X-Google-Smtp-Source: AGHT+IEAlOBTJFEUBorFwMW8uHsj5wzgJekj/jMdgUjnecohPwuoHtvDbKYTYR0nFptDqVyE58A+EMnqNEabfYdIgbw=
X-Received: by 2002:a05:690c:a81:b0:5d4:2e2b:7e56 with SMTP id
 ci1-20020a05690c0a8100b005d42e2b7e56mr2747508ywb.12.1701456358881; Fri, 01
 Dec 2023 10:45:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231110214618.1883611-1-victor@mojatatu.com> <20231110214618.1883611-5-victor@mojatatu.com>
 <ZV8SnZPBV4if5umR@nanopsycho> <CAM0EoMnwM836zTWJJsLa0QcqByGkcw0dMs8ScW7Cct3aBAQOMw@mail.gmail.com>
 <ZV9b0HrM5WespGMW@nanopsycho> <CAM0EoMnwAHO_AvEYiL=aTwNBjs29ww075Lq1qwvCwuYtB_Qz7A@mail.gmail.com>
 <ZV9tCT9d7dm7dOeA@nanopsycho> <CAAFAkD-awfzQTO6yRYeooXwW+7zEub0BiGkbke=o=fTKpzN__g@mail.gmail.com>
 <ZV+DPmXrANEh6gF8@nanopsycho> <CAM0EoMkQaEAaKc7D6kVe+p6f=-Ddd7enoKgRdeWBnqbN2zPhfA@mail.gmail.com>
 <CALnP8ZbaT+jdBvaggAPW=yiW61fip6cjnZcU48tb2-5orqdeMg@mail.gmail.com>
In-Reply-To: <CALnP8ZbaT+jdBvaggAPW=yiW61fip6cjnZcU48tb2-5orqdeMg@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 1 Dec 2023 13:45:47 -0500
Message-ID: <CAM0EoMmso7Y0g9jQ=FfJLuV9JTDct5Qqb5-W4+nd0Xb9DBkGkA@mail.gmail.com>
Subject: Re: [PATCH net-next RFC v5 4/4] net/sched: act_blockcast: Introduce
 blockcast tc action
To: Marcelo Ricardo Leitner <mleitner@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Jamal Hadi Salim <hadi@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, xiyou.wangcong@gmail.com, 
	vladbu@nvidia.com, paulb@nvidia.com, pctammela@mojatatu.com, 
	netdev@vger.kernel.org, kernel@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 1:52=E2=80=AFPM Marcelo Ricardo Leitner
<mleitner@redhat.com> wrote:
>
> On Mon, Nov 27, 2023 at 10:50:48AM -0500, Jamal Hadi Salim wrote:
> > On Thu, Nov 23, 2023 at 11:52=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> =
wrote:
> > >
> > > Thu, Nov 23, 2023 at 05:21:51PM CET, hadi@mojatatu.com wrote:
> > > >On Thu, Nov 23, 2023 at 10:17=E2=80=AFAM Jiri Pirko <jiri@resnulli.u=
s> wrote:
> > > >>
> > > >> Thu, Nov 23, 2023 at 03:38:35PM CET, jhs@mojatatu.com wrote:
> > > >> >On Thu, Nov 23, 2023 at 9:04=E2=80=AFAM Jiri Pirko <jiri@resnulli=
.us> wrote:
> > > >> >>
> > > >> >> Thu, Nov 23, 2023 at 02:37:13PM CET, jhs@mojatatu.com wrote:
> > > >> >> >On Thu, Nov 23, 2023 at 3:51=E2=80=AFAM Jiri Pirko <jiri@resnu=
lli.us> wrote:
> > > >> >> >>
> > > >> >> >> Fri, Nov 10, 2023 at 10:46:18PM CET, victor@mojatatu.com wro=
te:
> > > >> >> >> >This action takes advantage of the presence of tc block por=
ts set in the
> > > >> >> >> >datapath and multicasts a packet to ports on a block. By de=
fault, it will
> > > >> >> >> >broadcast the packet to a block, that is send to all member=
s of the block except
> > > >> >> >> >the port in which the packet arrived on. However, the user =
may specify
> > > >> >> >> >the option "tx_type all", which will send the packet to all=
 members of the
> > > >> >> >> >block indiscriminately.
> > > >> >> >> >
> > > >> >> >> >Example usage:
> > > >> >> >> >    $ tc qdisc add dev ens7 ingress_block 22
> > > >> >> >> >    $ tc qdisc add dev ens8 ingress_block 22
> > > >> >> >> >
> > > >> >> >> >Now we can add a filter to broadcast packets to ports on in=
gress block id 22:
> > > >> >> >> >$ tc filter add block 22 protocol ip pref 25 \
> > > >> >> >> >  flower dst_ip 192.168.0.0/16 action blockcast blockid 22
> > > >> >> >>
> > > >> >> >> Name the arg "block" so it is consistent with "filter add bl=
ock". Make
> > > >> >> >> sure this is aligned netlink-wise as well.
> > > >> >> >>
> > > >> >> >>
> > > >> >> >> >
> > > >> >> >> >Or if we wish to send to all ports in the block:
> > > >> >> >> >$ tc filter add block 22 protocol ip pref 25 \
> > > >> >> >> >  flower dst_ip 192.168.0.0/16 action blockcast blockid 22 =
tx_type all
> > > >> >> >>
> > > >> >> >> I read the discussion the the previous version again. I sugg=
ested this
> > > >> >> >> to be part of mirred. Why exactly that was not addressed?
> > > >> >> >>
> > > >> >> >
> > > >> >> >I am the one who pushed back (in that discussion). Actions sho=
uld be
> > > >> >> >small and specific. Like i had said in that earlier discussion=
 it was
> > > >> >> >a mistake to make mirred do both mirror and redirect - they sh=
ould
> > > >> >>
> > > >> >> For mirror and redirect, I agree. For redirect and redirect, do=
es not
> > > >> >> make much sense. It's just confusing for the user.
> > > >> >>
> > > >> >
> > > >> >Blockcast only emulates the mirror part. I agree redirect doesnt =
make
> > > >> >any sense because once you redirect the packet is gone.
> > > >>
> > > >> How is it mirror? It is redirect to multiple, isn't it?
> > > >>
> > > >>
> > > >> >
> > > >> >> >have been two actions. So i feel like adding a block to mirred=
 is
> > > >> >> >adding more knobs. We are also going to add dev->group as a wa=
y to
> > > >> >> >select what devices to mirror to. Should that be in mirred as =
well?
> > > >> >>
> > > >> >> I need more details.
> > > >> >>
> > > >> >
> > > >> >You set any port you want to be mirrored to using ip link, exampl=
e:
> > > >> >ip link set dev $DEV1 group 2
> > > >> >ip link set dev $DEV2 group 2
> > > >>
> > > >> That does not looks correct at all. Do tc stuff in tc, no?
> > > >>
> > > >>
> > > >> >...
> > > >> >
> > > >> >Then you can blockcast:
> > > >> >tc filter add devx protocol ip pref 25 \
> > > >> >  flower dst_ip 192.168.0.0/16 action blockcast group 2
> > > >>
> > > >> "blockcasting" to something that is not a block anymore. Not nice.
>
> +1
>
> > > >>
> > > >
> > > >Sorry, missed this one. Yes blockcasting is no longer appropriate  -
> > > >perhaps a different action altogether.
> > >
> > > mirret redirect? :)
> > >
> > > With target of:
> > > 1) dev (the current one)
> > > 2) block
> > > 3) group
> > > ?
> >
> > tbh, I dont like it - but we need to make progress. I will defer to Mar=
celo.
>
> With the addition of a new output type that I didn't foresee, that
> AFAICS will use the same parameters as the block output, creating a
> new action for it is a lot of boilerplate for just having a different
> name. If these new two actions can share parsing code and everything,
> then it's not too far for mirred also use. And if we stick to the
> concept of one single action for outputting to multiple interfaces,
> even just deciding on the new name became quite challenging now.
> "groupcast" is misleading. "multicast" no good, "multimirred" not
> intuitive, "supermirred" what? and so on..
>
> I still think that it will become a very complex action, but well,
> hopefully the man page can be updated in a way to minimize the
> confusion.

Ok, so we are moving forward with mirred "mirror" option only for this then=
...

cheers,
jamal

> Cheers,
> Marcelo
>
> >
> > cheers,
> > jamal
> >
> > >
> > > >
> > > >cheers,
> > > >jamal
> > > >> >
> > > >> >cheers,
> > > >> >jamal
> > > >> >
> > > >> >>
> > > >> >> >
> > > >> >> >cheers,
> > > >> >> >jamal
> > > >> >> >
> > > >> >> >> Instead of:
> > > >> >> >> $ tc filter add block 22 protocol ip pref 25 \
> > > >> >> >>   flower dst_ip 192.168.0.0/16 action blockcast blockid 22
> > > >> >> >> You'd have:
> > > >> >> >> $ tc filter add block 22 protocol ip pref 25 \
> > > >> >> >>   flower dst_ip 192.168.0.0/16 action mirred egress redirect=
 block 22
> > > >> >> >>
> > > >> >> >> I don't see why we need special action for this.
> > > >> >> >>
> > > >> >> >> Regarding "tx_type all":
> > > >> >> >> Do you expect to have another "tx_type"? Seems to me a bit o=
dd. Why not
> > > >> >> >> to have this as "no_src_skip" or some other similar arg, wit=
hout value
> > > >> >> >> acting as a bool (flag) on netlink level.
> > > >> >> >>
> > > >> >> >>
> >
>

