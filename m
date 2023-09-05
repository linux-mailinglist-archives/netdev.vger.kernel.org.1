Return-Path: <netdev+bounces-32161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B1679323F
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 01:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F281A1C20945
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 23:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC789101E2;
	Tue,  5 Sep 2023 23:05:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5A4DDC2
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 23:05:23 +0000 (UTC)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D37D127
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 16:05:22 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2680eee423aso1691602a91.2
        for <netdev@vger.kernel.org>; Tue, 05 Sep 2023 16:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1693955122; x=1694559922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EsA0ttbPbxLvlnzlM3ZexALoYqBACRtr7kaj33Z6LrE=;
        b=Y7m8zPJ6osDoEYci1eXIwA/wvg0z5orDVzolEbNlFSZql4cd4mWWRNSpznlTc8Nfey
         1kfdwr9IsEMxKCul1j+PaK89ijg9Z0fqe7an1n/NQlBjigBbQEwSmrvAKFzKcb1/vSHV
         rMQwqniZWrWfdhG2eP10wCbrYKolT7GGrJmbWoSEhIDAYxf/cC2BjLhLjyaiOg0qrVJB
         K4bOTMz2BfqwA9LoOYjKMWOObFjlFuvnrKy1bSl+k9r/2Qh9NNIjnhB6rIc45zwE4Xr9
         EPVW5PmVElpStI8otfobnYxieug2aiAMOFeyvtVdmjqZob3SN0AlC3/kHH3dRw2XebUY
         Mz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693955122; x=1694559922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EsA0ttbPbxLvlnzlM3ZexALoYqBACRtr7kaj33Z6LrE=;
        b=TJAz+jMLiJQB2QlGv+uuEJ95spBZ+60Rx4c9fV+U0XmCBnnwgNyONzyC8Y1pjml7Ae
         abh2vIa+7L1pOz06ckRjUTSwZn4fMlc+rXKSk8OEgRiX6OEgpbZxx8zJWAbodIpEZ9O7
         V9VVM2vEAJsqshgufKlrLyiGbyZQCbazQDpJPm8ikN5CR5ZHRbIhiyvg4Yd4OxWthZ8d
         xrQ2zUYWVFR2kf8pTQIFJg/N6a+fw1wtkWRqzStD88c1dBRvu3fwQqu+1895Ef6SaP2j
         5+D6SP+48mLKaBX4VmACLK7J5x721WZNdRpjHTtA9HP8/4uIMvjJsazyVLq8s3vKi2kX
         QLpQ==
X-Gm-Message-State: AOJu0Yy6/n59iOyhmILwxCIRcUwvWpn1hx7Tr3Y9sA/TdG3FCTPZ27tA
	73toDb5WRD0E8DhwN/n1h6z8MedQ2qAnX7qLKb24KA==
X-Google-Smtp-Source: AGHT+IFRj8YQuRHH/lR8GzALQ14CWdzMHrhNQIzuJlIFxeDKzkqQNw+dZisF+QvrHEtqjeegoSBGB6+wrouawe3F4dA=
X-Received: by 2002:a17:90a:d987:b0:263:5d25:150c with SMTP id
 d7-20020a17090ad98700b002635d25150cmr10427718pjv.29.1693955121670; Tue, 05
 Sep 2023 16:05:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230904021455.3944605-1-junfeng.guo@intel.com> <20230905153734.18b9bc84@kernel.org>
In-Reply-To: <20230905153734.18b9bc84@kernel.org>
From: Tom Herbert <tom@herbertland.com>
Date: Tue, 5 Sep 2023 16:05:09 -0700
Message-ID: <CALx6S34B_BvkNuqALCCT+2V2dL8rwr9n_DnRfevjkW4UwMF=pw@mail.gmail.com>
Subject: Re: [PATCH iwl-next v9 00/15] Introduce the Parser Library
To: Jakub Kicinski <kuba@kernel.org>
Cc: Junfeng Guo <junfeng.guo@intel.com>, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, anthony.l.nguyen@intel.com, 
	jesse.brandeburg@intel.com, qi.z.zhang@intel.com, ivecera@redhat.com, 
	sridhar.samudrala@intel.com, horms@kernel.org, edumazet@google.com, 
	davem@davemloft.net, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 5, 2023 at 3:37=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon,  4 Sep 2023 10:14:40 +0800 Junfeng Guo wrote:
> > Current software architecture for flow filtering offloading limited
> > the capability of Intel Ethernet 800 Series Dynamic Device
> > Personalization (DDP) Package. The flow filtering offloading in the
> > driver is enabled based on the naming parsers, each flow pattern is
> > represented by a protocol header stack. And there are multiple layers
> > (e.g., virtchnl) to maintain their own enum/macro/structure
> > to represent a protocol header (IP, TCP, UDP ...), thus the extra
> > parsers to verify if a pattern is supported by hardware or not as
> > well as the extra converters that to translate represents between
> > different layers. Every time a new protocol/field is requested to be
> > supported, the corresponding logic for the parsers and the converters
> > needs to be modified accordingly. Thus, huge & redundant efforts are
> > required to support the increasing flow filtering offloading features,
> > especially for the tunnel types flow filtering.
>
> Are you talking about problems internal to ICE or the flower interface?
>
> > This patch set provides a way for applications to send down training
> > packets & masks (in binary) to the driver. Then these binary data
> > would be used by the driver to generate certain data that are needed
> > to create a filter rule in the filtering stage of switch/RSS/FDIR.
>
> What's the API for the user? I see a whole bunch of functions added here
> which never get called.
>
> > Note that the impact of a malicious rule in the raw packet filter is
> > limited to performance rather than functionality. It may affect the
> > performance of the workload, similar to other limitations in FDIR/RSS
> > on AVF. For example, there is no resource boundary for VF FDIR/RSS
> > rules, so one malicious VF could potentially make other VFs
> > inefficient in offloading.
> >
> > The parser library is expected to include boundary checks to prevent
> > critical errors such as infinite loops or segmentation faults.
> > However, only implementing and validating the parser emulator in a
> > sandbox environment (like ebpf) presents a challenge.
> >
> > The idea is to make the driver be able to learn from the DDP package
> > directly to understand how the hardware parser works (i.e., the
> > Parser Library), so that it can process on the raw training packet
> > (in binary) directly and create the filter rule accordingly.
>
> No idea what this means in terms of the larger networking stack.
>

Yes, creating an elaborate mechanism that is only usable for one
vendor, e.g. a feature of DDP, really isn't very helpful. Parsing is a
very common operation in the networking stack, and if there's
something with the vanglorious name of "Parser Library" really should
start off as being a common, foundational, vendor agnostic library to
solve the larger problem and provide the most utility. The common
components would define consistent user and kernel interfaces for
parser offload, interfaces into the NIC drivers would be defined to
allow different vendors to implement parser offload in their devices.

The concepts in kParser patch "net/kparser: add kParser" were aligned
with what the backend of Parser Library might be. That path introduced
iproute commands to program an in kernel parser extensible to support
arbitrary protocols (including constructs like TLVs, flag fields, and
now even nested TLVs). It is quite conceivable that these commands
could be sent to the device to achieve programmable parser offload.

Tom


> > Based on this Parser Library, the raw flow filtering of
> > switch/RSS/FDIR could be enabled to allow new flow filtering
> > offloading features to be supported without any driver changes (only
> > need to update the DDP package).
>
> Sounds like you are talking about some vague "vision" rather than
> the code you're actually posting.
>
> Given that you've posted 5 versions of this to netdev and got no
> notable comments, please don't CC netdev on the next version
> until you get some reviews inside Intel. Stuff like:
>
> +#define ICE_ERR_NOT_IMPL               -1
>
> should get caught by internal review.
>

