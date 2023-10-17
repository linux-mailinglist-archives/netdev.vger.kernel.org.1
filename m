Return-Path: <netdev+bounces-42018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E915E7CCADD
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 20:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A213F281AAF
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 18:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C27B2D04E;
	Tue, 17 Oct 2023 18:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FU9tRGjr"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF38EBE;
	Tue, 17 Oct 2023 18:38:30 +0000 (UTC)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63929F;
	Tue, 17 Oct 2023 11:38:29 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1dcf357deedso3551585fac.0;
        Tue, 17 Oct 2023 11:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697567909; x=1698172709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJtwSVEQlll1Ac78s7VWrKKMPrlMY5ewqkcx5HFvIho=;
        b=FU9tRGjrZGcX6jOI0mrlEG9zdYTg3DZfCwNgOSNICU7nto5GnJvj3duD58OS9aVj0j
         ieEEESY9zDA9kdhVVmxgIJDtekOzf+CB/ZDlIgPCupa+f08qzawXAs6zws8nfRTCoesJ
         sgn58OId7hEQa2wMTyIzY6UQdmMjd/dV4VlfQcydxEsVw86nQZc42faiM6WdMdczzj8T
         L06wF7vctMb4J+oBymsa15TVSCsiCy8Hj11qh9asFHQ7mmAgx2bBqh6YEkcC1WniLE6M
         v/cUGasiTDEcznDCDHwuVHA7u0guQKoW44a06mN3Dk3MT95LqcV2yj7LhfAig8KsRSlb
         YIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697567909; x=1698172709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wJtwSVEQlll1Ac78s7VWrKKMPrlMY5ewqkcx5HFvIho=;
        b=C1a14FXdyL+iuo9DELxHQUGfQFaj20/zpNdlEdBrJx0OyiqDvvhmpyjOS/InOCqpo2
         UdmrIiD7jn1Brqcxo26SK/KzCj5RT1/0yCxIz/gJ2hMzJXGGrXBOKY20a5kQcgRRR3hM
         7MLQLeEHjN4lNZDQ8cUqBdwk8Fgf94r9WKhdqlN8D7bXKLP7X6w8g41mA41SNo/kSjfJ
         9pgytt7uMjlp31rC5/QggDdxUwEtyt1Mtifx1MJuTjHbuG3WJinWYmwLn2hg2JubtBDH
         4TBJHAjtHIuGATmnlufjP+B/oWgWaFmgHFCpAxtkWE1lBEYmor2XqHK+KEyPUBOK9nSs
         SeWg==
X-Gm-Message-State: AOJu0YzE+Dk/B7a8aJo3WK7E84Wtlk9Yx/PYpmOJKz5+V8HYTtZ22Sp1
	uc73mvsKXziTigQLDw/KRbQZ8t6jUUgMM/2UGUI=
X-Google-Smtp-Source: AGHT+IGhB46ZnnksIceehl/eZ4OJS5WI52FwMdLrh/SbBZ5dRqQOLhaiq9/8nFZ5GRB/iNQdISWXdRc0mMZtgRSmlu8=
X-Received: by 2002:a05:6870:1708:b0:1e9:8ab9:11cd with SMTP id
 h8-20020a056870170800b001e98ab911cdmr3815915oae.45.1697567909015; Tue, 17 Oct
 2023 11:38:29 -0700 (PDT)
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
 <20231016163059.23799429@kernel.org>
In-Reply-To: <20231016163059.23799429@kernel.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 17 Oct 2023 11:37:52 -0700
Message-ID: <CAKgT0Udyvmxap_F+yFJZiY44sKi+_zOjUjbVYO=TqeW4p0hxrA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/6] net: ethtool: allow symmetric-xor RSS
 hash for any flow type
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ahmed Zaki <ahmed.zaki@intel.com>, netdev@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, corbet@lwn.net, jesse.brandeburg@intel.com, 
	anthony.l.nguyen@intel.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, vladimir.oltean@nxp.com, andrew@lunn.ch, horms@kernel.org, 
	mkubecek@suse.cz, willemdebruijn.kernel@gmail.com, linux-doc@vger.kernel.org, 
	Wojciech Drewek <wojciech.drewek@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 4:31=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 16 Oct 2023 15:55:21 -0700 Alexander Duyck wrote:
> > It would make more sense to just add it as a variant hash function of
> > toeplitz. If you did it right you could probably make the formatting
> > pretty, something like:
> > RSS hash function:
> >     toeplitz: on
> >         symmetric xor: on
> >     xor: off
> >     crc32: off
> >
> > It doesn't make sense to place it in the input flags and will just
> > cause quick congestion as things get added there. This is an algorithm
> > change so it makes more sense to place it there.
>
> Algo is also a bit confusing, it's more like key pre-processing?
> There's nothing toeplitz about xoring input fields. Works as well
> for CRC32.. or XOR.

I agree that the change to the algorithm doesn't necessarily have
anything to do with toeplitz, however it is still a change to the
algorithm by performing the extra XOR on the inputs prior to
processing. That is why I figured it might make sense to just add a
new hfunc value that would mean toeplitz w/ symmetric XOR.

> We can use one of the reserved fields of struct ethtool_rxfh to carry
> this extension. I think I asked for this at some point, but there's
> only so much repeated feedback one can send in a day :(

Why add an extra reserved field when this is just a variant on a hash
function? I view it as not being dissimilar to how we handle TSO or
tx-checksumming. It would make sense to me to just set something like
toeplitz-symmetric-xor to on in order to turn this on.

