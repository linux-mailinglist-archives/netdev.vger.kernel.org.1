Return-Path: <netdev+bounces-85235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D84899DD7
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 15:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBDFD1F21A7E
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 13:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E9216D32E;
	Fri,  5 Apr 2024 13:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SaC1mLBD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FDF16D315
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 13:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712322058; cv=none; b=cmCiBPv2a/ESzI4OEi1g43biH0fouBmP0bDeFtDN2Jtv28Q5NogqkEGF4AvUDe91uUro7xGz57pUca2tOY18UPz3ClW0fA5KSz3bXjYrJy8Ae3xZjp1eHKUbKGh7ilhAFi6NOzn5FbfY06nldSRETms+iBTe9ylrDtgpCd5Ov7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712322058; c=relaxed/simple;
	bh=JimeStx1AxEiTnKcsJagFdmWpRaIN8O0L+53phs34Q4=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PRVY0UFRBrVITBEMjl+D2gDYDSFhoouhcBOo7sopDioTmtJAs5LDvMvEx1BRHu43bdcB3z0H5XsFn6HNLG8tgsFgVK0Ox2/E/Mq8v/eWB0pQkxfW0mfBHOldq6xJzWqnDNGxPpelhYifTmvd/h191tlt/gxHFS1tGLPEtnTGt/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SaC1mLBD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712322055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GxZUtQtjVGjRXF/qBbUdPZx5hjqkZReSzIfcUtT+LM8=;
	b=SaC1mLBD6JGbqSz+rfA340TU2z79wuRzLeOJrCoYcvqCond89V+kNBrVpUlLxSFFRBPnfr
	aheIhsg6/KUhhHhY7ttzEgpj7qoBQ45/6KoVu97vmpDUOJd0ic3uHo1q0G88fkLNlxLHl0
	yg9S7Dro9W3fSZjDUSb+hJkA+s/rujA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-Sd5Fij_PNwG_jb-73pWhjA-1; Fri, 05 Apr 2024 09:00:52 -0400
X-MC-Unique: Sd5Fij_PNwG_jb-73pWhjA-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-56c3dc8d331so1503944a12.2
        for <netdev@vger.kernel.org>; Fri, 05 Apr 2024 06:00:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712322051; x=1712926851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GxZUtQtjVGjRXF/qBbUdPZx5hjqkZReSzIfcUtT+LM8=;
        b=ruP2jc8pcKuQmmCN04Qr5fT5OoVYqpR5ouUCYiEDrMjEyYQMZWZwXB5hGYoQ4IwWw4
         CjbbOl3ySSJzfm01x6TfBqpPVBJvgUwajxVMUdwCFaktk5KMNVMC8jsceJ4o4Q1PKC4D
         ucQnpfOxsWQ2fwzfQZ9sG/CvH0sWgL1xNEkZMffXGF/lDkrEsvdOrG/SFxW4NuWWXnzg
         GaYVkebWlpTONAZ8Ur3SnACn/RySr/KxiWI+7fxO4HQ6clouZh0L146x4C6FRb7PH5W3
         ZPOKCCiCb3f/peZKRaFVpFYRkKHsEljPf8m1IQ1ODTEMzSd2Zfpga7agcDSZC9HCFPH/
         B4mg==
X-Gm-Message-State: AOJu0YzfLzo2QwCyZIYLQgXe44Iox0ozLl9wxNniz7we7DkqqS4QUPLT
	fO0Uyjz2djKu04GMMH4iIOT+aR48nppyVEJSI3p3ZdKhwv3fuw0CuZEALZRvkyRjOOayqslM+Pf
	wVkAvGW4qFJZ2N3mbE2eU0OMjguswZIbrEI9hR+SM2F6ubhS5L7FroV++55dgdip6KUQZgUUygk
	qLF8dxEarMn2WevsrxQRVZ6qvueECP
X-Received: by 2002:a50:c34f:0:b0:56e:60d:9b16 with SMTP id q15-20020a50c34f000000b0056e060d9b16mr936774edb.6.1712322049702;
        Fri, 05 Apr 2024 06:00:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrcSHtZHcXL3adDj19d+7C6gNUs7CfvA+q8qubkrmEmxnJA3t0cmFqpbTdpIPTX/UI1obiDpAzCU1yJ4Fa/O8=
X-Received: by 2002:a50:c34f:0:b0:56e:60d:9b16 with SMTP id
 q15-20020a50c34f000000b0056e060d9b16mr936715edb.6.1712322048666; Fri, 05 Apr
 2024 06:00:48 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 5 Apr 2024 06:00:47 -0700
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20240404122338.372945-1-jhs@mojatatu.com> <CAM0EoMmp83pcVKuaDSL2UiD0xMZKtDTn_qod3GbPv3c1Qaf3hw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAM0EoMmp83pcVKuaDSL2UiD0xMZKtDTn_qod3GbPv3c1Qaf3hw@mail.gmail.com>
Date: Fri, 5 Apr 2024 06:00:47 -0700
Message-ID: <CALnP8Za0aTNLZzP9Vv0eeXz+eTb0RySyompDuNeCS71vbwAj_g@mail.gmail.com>
Subject: Re: [PATCH net-next v14 00/15] Introducing P4TC (series 1)
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, Mahesh.Shirshyad@amd.com, 
	Vipin.Jain@amd.com, tomasz.osinski@intel.com, jiri@resnulli.us, 
	xiyou.wangcong@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, vladbu@nvidia.com, dan.daly@intel.com, 
	andy.fingerhut@gmail.com, chris.sommers@keysight.com, mattyk@nvidia.com, 
	horms@kernel.org, khalidm@nvidia.com, toke@redhat.com, daniel@iogearbox.net, 
	victor@mojatatu.com, pctammela@mojatatu.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2024 at 08:44:29AM -0400, Jamal Hadi Salim wrote:
> On Thu, Apr 4, 2024 at 8:23=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
> >
> >
> > This is the first patchset of two. In this patch we are submitting 15 w=
hich
> > cover the minimal viable P4 PNA architecture.
> > Please, if you want to discuss a slightly tangential subject like offlo=
ad
> > or even your politics then start another thread with a different subjec=
t
> > line.  The way you do it is to change the subject line to for example
> > "<Your New Subject here> (WAS: <original subject line here>)".
> >
> > In this cover letter i am restoring text i took out in V10 which stated
> > "our requirements".
> >
> > Martin, please look at patch 14 again. The bpf selftests for kfuncs is
> > sloted for series 2. Paolo, please take a look at 1, 3, 6 for the chang=
es
> > you suggested. Marcelo, because we made changes to patch 14, I have
> > removed your reviewed-by. Can you please take another look at that patc=
h?
>
> Sorry, Marcelo - you already reviewed and we restored your reviewed-by.

Aye.

Cheers,
Marcelo


