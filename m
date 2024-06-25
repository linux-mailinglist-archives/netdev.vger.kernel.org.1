Return-Path: <netdev+bounces-106539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E701916ACB
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 16:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 073DCB240EC
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 14:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D1B16EBF3;
	Tue, 25 Jun 2024 14:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0qbbv0nw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A9516F0FD
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 14:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719326470; cv=none; b=GlZRC0T/9qbbPcqGkg3ZkU+S+k7B9SotD5W8m5dHrN2Q2W4aJTmiLAGsRSk6cjMLLtO8hAu28EygafD072fs6vutYv6niM98L5sRbcNjOaYyGL6KyLNSZdbCeeNO3yknv+YLVuP8SL6FK4AP8xe0jrgGsUe8hm4f4yoE6FqHnVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719326470; c=relaxed/simple;
	bh=WcLQ0nCECrABXjRLwF2IijitRAkKZkzGVL7JK1NYMW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dT/jBhJA4n+sGdlNVZxjV6LCh/AdpFEFDL/r783LsrI9yOsBkhYGrmTEcFEppOWnWM62TZFnE2YcycQRvnair+Y8Fi7C6ijsK1QIO2Zu1fap8sRPV5mWPNQflMHktqcmpZ257EijsaJRgWwZBP0MdBo1CdabKr5yI0gez7LfPrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0qbbv0nw; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57d16251a07so12479a12.1
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 07:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719326467; x=1719931267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WcLQ0nCECrABXjRLwF2IijitRAkKZkzGVL7JK1NYMW0=;
        b=0qbbv0nwbLsm80gZ5EE+dVogudxbSWfwpsPgtzMZshIKyTYv3wDAAmtqW2Y7i7AoN0
         g4vxrt7OWVDOU21qvpiTnnnWPG3FWPF5TD0YM+igTwcLqCECDS4N00TOok43Hhi+MwkN
         BZIsk/L4M1QLU1AXEIr/olcT6im/+G4iUC3YyLE1gST+TN/uLzDXuneku4cFs0xsHU/v
         8/KZpMqpVj68JgRZa+DRYMkp2G7VTA3GwychqN37JizdzKMj0DdoUclRmyETmabMNGJ1
         IXAO7TrN5HsOosjpFOnAKTBfxm4czF3Vs/hQN/mtzql/vDAcFMaYn7ELN6MZYhNhjtSq
         ONJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719326467; x=1719931267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WcLQ0nCECrABXjRLwF2IijitRAkKZkzGVL7JK1NYMW0=;
        b=SfIW/+B0njQ1wdMlislLa5RPHpdTN1umG1xibUsTrNHYwtpHNjYeqcE/m8K1wiZ/7u
         aYSeuTL0a82NevuwTQwYQ8W+nqkh2kcj3AYDhCy0bkUUTBTjIoUCtSnKNJLKNN04gRv7
         hF4o/doINnjQmyBKWFErpv8Q5RSH71nwlmVg+SGjfMUUwdY9CTyZ24/E1U3ZVh1tMXIJ
         GerqQXLRaXxKL6MEsWpamHScPo30gKfN5WdFNXsNB9q6dLWsauZbn0BOiodeFPZU8yb6
         A0QE4rozXgHs2zSqhR41ehnQ0lbYp3g5GMRqxBl0hH8YTxbIR6g2A4ogIXS0AFJAMyeF
         //sA==
X-Forwarded-Encrypted: i=1; AJvYcCXz+bSavsoeHplnENXWeEMnqMr3VI2GzGO/xeowk6ZYrqisS6j91xe9aChWOH+W3fyeDViuHKMd0bTMWTB5vjrTbZC0R9VD
X-Gm-Message-State: AOJu0YxCVfQzO0Xikpsi2D7QJ6HB6MqUl4wpEFJSksCVF9U6YbwY82Oh
	Rap/V2nE1Rb8NoRqybDy8LBh15tKD6AWZ88dOz4lvdGHidkhe0mkKwgEMuv51ihbzVdI8wvRVNi
	yL6ymTPiDuBeUbLHHQzfMKWLqINhdeVfSwppx
X-Google-Smtp-Source: AGHT+IHQgjj5A9VwGqPiPVJRYzwCVnxoIth9ETdrhO8JjmTzsupjXOr0VBjenXJ1ERidLpYhIXu2BVcWvdmU+40CvxA=
X-Received: by 2002:a05:6402:cad:b0:582:c149:ca76 with SMTP id
 4fb4d7f45d1cf-582c1590e9emr40048a12.7.1719326466999; Tue, 25 Jun 2024
 07:41:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240623081248.170613-1-sagi@grimberg.me> <1c5f5650ba2ffe99b068266ceb6e69f59661563f.camel@redhat.com>
 <20240625071028.2324a9f5@kernel.org>
In-Reply-To: <20240625071028.2324a9f5@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 25 Jun 2024 16:40:54 +0200
Message-ID: <CANn89iKwHzQPx5DLcxy_hX20d+dUv09b7fs3o_kCRyabzYXOEQ@mail.gmail.com>
Subject: Re: [PATCH v2] net: allow skb_datagram_iter to be called from any context
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Sagi Grimberg <sagi@grimberg.me>, netdev@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 4:10=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 25 Jun 2024 15:27:41 +0200 Paolo Abeni wrote:
> > On Sun, 2024-06-23 at 11:12 +0300, Sagi Grimberg wrote:
> > > We only use the mapping in a single context, so kmap_local is suffici=
ent
> > > and cheaper. Make sure to use skb_frag_foreach_page as skb frags may
> > > contain highmem compound pages and we need to map page by page.
> > >
> > > Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> >
> > V1 is already applied to net-next, you need to either send a revert
> > first or share an incremental patch (that would be a fix, and will need
> > a fixes tag).
> >
> > On next revision, please include the target tree in the subj prefix.
>
> I think the bug exists in net (it just requires an arch with HIGHMEM
> to be hit). So send the fix based on net/master and we'll deal with
> the net-next conflict? Or you can send a revert for net-next at the
> same time, but I think the fix should target net.

I have not seen a merged patch yet.

In any case, some credits would be nice.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202406161539.b5ff7b20-oliver.sang@in=
tel.com

