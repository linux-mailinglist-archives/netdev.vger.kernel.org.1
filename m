Return-Path: <netdev+bounces-42019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F5B7CCAEB
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 20:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27062B210E5
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 18:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2FB2D055;
	Tue, 17 Oct 2023 18:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjQF7/oL"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C2FEBE;
	Tue, 17 Oct 2023 18:42:40 +0000 (UTC)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D10694;
	Tue, 17 Oct 2023 11:42:39 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-3512fae02ecso23252825ab.2;
        Tue, 17 Oct 2023 11:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697568159; x=1698172959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hY8pDtSj4J0DMbNt62MAWtdtLc0zQPLrC85LJaVi6Wk=;
        b=TjQF7/oL68eXIW23mmrQCeqKnKK7llgKoXkTATePynkZ8AYzePvVDTBYHDIJruY5Gu
         JCF+FZbEfO0kwkhhXeZTlf2BMTNFO7bLzT+WxFSY+7kq3o5DDJEir54EdsTn5WmnvSLO
         9sZIZTqqXHS/UoHDXnVm+OcO/0UnFvOtXr2g0EWUW2phYwEsu+uAnE7PBa4mpz0u9yWW
         TkbRfnc9Sd2QVIhlOPXO/zMP41ttiQSjvo3WThsAzzLPMmqFgiDdB297quToCGew97D+
         Xq7SwzpM4YISlXiSorJoHDN23M1IJTxW5C37E8F57KlHsujZyK2rXgprpBbFipelXuZQ
         xrpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697568159; x=1698172959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hY8pDtSj4J0DMbNt62MAWtdtLc0zQPLrC85LJaVi6Wk=;
        b=Irz0geDSR7FB+ai3g4vV2pXuCBAiETzwKe/oCys/KuJe4ng88a5Ux2Bwe/mONfiQJ3
         dqznLHPdngZq+fn2CrnJl9SRx3aG1zEv4bRTgPDoelqXbaeTRFeBPMr7h+fetJ7XQVRd
         Q3trBneUxmRc8KOYqzcJy1Swkh4YhYuUlXsxNl5nNQDb+Od1oZ0U6JIiQIluSGPGjOMI
         tomnxVaDfd6NkS3RoV/gFaF+EMzoyD8StJlD184/vr6HnhK9lGDVL2ONPGB4YHCcccTQ
         TxE5HrLlS9r5a58dLQ85OnA4PGypizmam1yeM7kUxVkA/JSnj0VkUHvtT1rgKKnVFIgs
         8uSQ==
X-Gm-Message-State: AOJu0YwyCSpOQnjAzTyhNuacxyA+vGlq0lXJbv57jMniRDLGENKjvZHm
	mt/6xwcgYeBJupZ3rzrKMiLcTP4s+4axKUEGBpY=
X-Google-Smtp-Source: AGHT+IFCpZJ85xe399/2lA7A2dJ4nyIOWeBkwjpG17gzDCFjwl44jwsihXr9SarpLA0QM/9JWhFTjXAtdB3Pf6+tkPk=
X-Received: by 2002:a05:6e02:12e7:b0:351:4e9f:5606 with SMTP id
 l7-20020a056e0212e700b003514e9f5606mr4292877iln.10.1697568158863; Tue, 17 Oct
 2023 11:42:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016154937.41224-1-ahmed.zaki@intel.com> <20231016154937.41224-2-ahmed.zaki@intel.com>
 <8d1b1494cfd733530be887806385cde70e077ed1.camel@gmail.com>
 <26812a57-bdd8-4a39-8dd2-b0ebcfd1073e@intel.com> <CAKgT0Ud7JjUiE32jJbMbBGVexrndSCepG54PcGYWHJ+OC9pOtQ@mail.gmail.com>
 <14feb89d-7b4a-40c5-8983-5ef331953224@intel.com> <CAKgT0UfcT5cEDRBzCxU9UrQzbBEgFt89vJZjz8Tow=yAfEYERw@mail.gmail.com>
 <20231016163059.23799429@kernel.org> <afb4a06f-cfba-47ba-adb3-09bea7cb5f00@intel.com>
In-Reply-To: <afb4a06f-cfba-47ba-adb3-09bea7cb5f00@intel.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 17 Oct 2023 11:42:02 -0700
Message-ID: <CAKgT0UdPe_Lb=E+P+zuwyyWVfqBQWLaomwGLwkqnsr0mf40E+g@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/6] net: ethtool: allow symmetric-xor RSS
 hash for any flow type
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, corbet@lwn.net, jesse.brandeburg@intel.com, 
	anthony.l.nguyen@intel.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, vladimir.oltean@nxp.com, andrew@lunn.ch, horms@kernel.org, 
	mkubecek@suse.cz, willemdebruijn.kernel@gmail.com, linux-doc@vger.kernel.org, 
	Wojciech Drewek <wojciech.drewek@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 5:08=E2=80=AFPM Ahmed Zaki <ahmed.zaki@intel.com> w=
rote:
>
>
>
> On 2023-10-16 17:30, Jakub Kicinski wrote:
> > On Mon, 16 Oct 2023 15:55:21 -0700 Alexander Duyck wrote:
> >> It would make more sense to just add it as a variant hash function of
> >> toeplitz. If you did it right you could probably make the formatting
> >> pretty, something like:
> >> RSS hash function:
> >>      toeplitz: on
> >>          symmetric xor: on
> >>      xor: off
> >>      crc32: off
> >>
> >> It doesn't make sense to place it in the input flags and will just
> >> cause quick congestion as things get added there. This is an algorithm
> >> change so it makes more sense to place it there.
> >
> > Algo is also a bit confusing, it's more like key pre-processing?
> > There's nothing toeplitz about xoring input fields. Works as well
> > for CRC32.. or XOR.
> >
> > We can use one of the reserved fields of struct ethtool_rxfh to carry
> > this extension. I think I asked for this at some point, but there's
> > only so much repeated feedback one can send in a day :(
>
> Sorry you felt that. I took you comment [1]:
>
> "Using hashing algo for configuring fields feels like a dirty hack".
>
> To mean that the we should not use the hfunc API ("ethtool_rxfh"). This
> is why in the new series I chose to configure the RSS fields. This also
> provides the user with more control and better granularity on which
> flow-types to be symmetric, and which protocols (L3 and/or L4) to use. I
> have no idea how to do any of these via hfunc/ethtool_rxfh API so it
> seemed a better approach.
>
> I see you marked the series as "Changes Requested". I will send a new
> version tomorrow and move the sanity checks inside ice_ethtool.
>
>
> [1]: https://lore.kernel.org/netdev/20230824174336.6fb801d5@kernel.org/

So one question I would have is what happens if you were to ignore the
extra configuration that prevents people from disabling either source
or destination from the input? Does it actually have to be hard
restricted or do you end up with the hardware generating non-symmetric
hashes because it isn't doing the XOR with both source and destination
fields?

My thought would be to possibly just look at reducing your messaging
to a warning from the driver if the inputs are not symmetric, but you
have your symmetric xor hash function enabled.

