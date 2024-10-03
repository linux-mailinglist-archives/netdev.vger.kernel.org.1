Return-Path: <netdev+bounces-131797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6418798F9AB
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 00:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAE6E1F23121
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 22:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB211C7B79;
	Thu,  3 Oct 2024 22:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNSWC2zG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9805B824BD
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 22:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727993561; cv=none; b=PWJWnhoKveDaynmwequSpaUu+wiOUkA2WfMUsqCLCgOqbBvYEen7RL/qTh4jfVrt4RqgTnxtVwvUPPVcXY0UNPESiIbC2Ap+j7O/5Y/24pw0WoHtJNtMfCy4j7ajoAu6EECD304d+/15LGJzMC8K/gbZH3I5HBVyiFlVqMTh5qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727993561; c=relaxed/simple;
	bh=FIsTx9gAnAZ4+f9ijd2jCSreHHjrlDIL1EegxEdBNko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOB1AtgXRKeYoxiS2iX7EijuOSXCuDJPxcTI2ygODkJf+hjk2QD5cULSaZn8Yurq+a5fiiVhUus0FmCsiUHZRCwDwHuCTelUdBuzuV0l5PVnQsF3h9UPoRZ2mydR+TKP2ZIbLaOjase2iF6o1FJsawJwuXU5FWpsqDJsbYwBd64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNSWC2zG; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71dc4451fffso1490863b3a.2
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 15:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727993559; x=1728598359; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i41AgYSqsz8N+S1EwL66geaOVck9qp+/JrG6VOfkcIg=;
        b=TNSWC2zGSV/oIPxXi0gThtkq8e5l2tWwIkvMnrBJvpM54GWAzikaoYjMZODZcjvZUd
         /RXXuVaUiDUcBRLQL8CjEVbAyu2RZMZ7C/GX3HBHxEAhazwmTR3laZGYhyGXu0Z49xdr
         S4SSHIvjH675S5icrh3eoKaYjGvqngtzAfQ0//FhHhRfY/+eumtw+qCnJYG3VE8rAb+6
         DPiWGAhHaOHLTXErmqxs2+YCr0eQmPDjO9Qn+4U4io9mbOQma4Wd8V/IzmDs/4hF7yJk
         SIz+DMRfVWGaCa4dDTxFPSG/AUbkaV7MHFguKM6GIWS7ZWBUQ9VwVDmcAwy34QTR0s+w
         aRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727993559; x=1728598359;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i41AgYSqsz8N+S1EwL66geaOVck9qp+/JrG6VOfkcIg=;
        b=T821yPC6kvO1e3TC74G+kXMxhUz8duv6NpC+jUpJhjr6n+UhXLgw23UlCnP1lljUnH
         q00e19Nq6IBx4bUVvsFT7p2z91BHTRfHfPvLZGswdgrOUlN1QwpZHDv5oLri3CPwI+ek
         fW2ATwjc1E/HBxbMsLRRRoMX2LNgDtPwRhupyG/NPAutHJOjirzzOeOo8/t+UXOMN14M
         wisW8szdHUAPODBeWS32HW+0n7YXICbwAytXbypbUK33BNC2toTj0DJYbqho9STgtUj9
         QPfHFr23k3hBLs0KMIu3tdLg+7MC433mVN+1Fhyz4/HSTkDxcqgxvv1D+wvmoQ0hyZuE
         x4DQ==
X-Forwarded-Encrypted: i=1; AJvYcCWznZVVWRA9z5rnsvoGZ1lcBjqj1NVbb0xT80TLosT8YqQJLcVyUwgr8WR+HYPWNSJvjRbox+s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Q7gozcPDRQDjMSxx7Xo/AdETDTOiSWaebCSrJhgBFqb7Z1I5
	qKvQbPsuWnO/mazIGh7qPFhPJYMkzk6eEX2fANDVwv8fL7o9cno=
X-Google-Smtp-Source: AGHT+IGrDsBD0+HtpVjdLCedI6A6wqOYkGYXX7NrIC1NxBw1Xg2ftc5sSZkzW+ojsNRtPuy+5FCPZw==
X-Received: by 2002:a05:6a20:c886:b0:1d5:1252:ebe2 with SMTP id adf61e73a8af0-1d6dfa259damr1166127637.5.1727993558878;
        Thu, 03 Oct 2024 15:12:38 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9dcb5d85csm1211740a12.84.2024.10.03.15.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 15:12:38 -0700 (PDT)
Date: Thu, 3 Oct 2024 15:12:37 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v2 07/12] selftests: ncdevmem: Properly reset
 flow steering
Message-ID: <Zv8W1dfhsmtsw5oT@mini-arch>
References: <20240930171753.2572922-1-sdf@fomichev.me>
 <20240930171753.2572922-8-sdf@fomichev.me>
 <CAHS8izO0Z6soYWLeU0c-8EKP5monscFqpnw6gn5OkxoqwTxKbg@mail.gmail.com>
 <Zv7Jbf5yVO9eV8Md@mini-arch>
 <CAHS8izOtNP2DXHWd_NcXTbD=P9s055g-EWWhknv4VkPh2NXKvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izOtNP2DXHWd_NcXTbD=P9s055g-EWWhknv4VkPh2NXKvg@mail.gmail.com>

On 10/03, Mina Almasry wrote:
> On Thu, Oct 3, 2024 at 9:42 AM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >
> > On 10/03, Mina Almasry wrote:
> > > On Mon, Sep 30, 2024 at 10:18 AM Stanislav Fomichev <sdf@fomichev.me> wrote:
> > > >
> > > > ntuple off/on might be not enough to do it on all NICs.
> > > > Add a bunch of shell crap to explicitly remove the rules.
> > > >
> > > > Cc: Mina Almasry <almasrymina@google.com>
> > > > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > > > ---
> > > >  tools/testing/selftests/net/ncdevmem.c | 13 ++++++-------
> > > >  1 file changed, 6 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
> > > > index 47458a13eff5..48cbf057fde7 100644
> > > > --- a/tools/testing/selftests/net/ncdevmem.c
> > > > +++ b/tools/testing/selftests/net/ncdevmem.c
> > > > @@ -207,13 +207,12 @@ void validate_buffer(void *line, size_t size)
> > > >
> > > >  static int reset_flow_steering(void)
> > > >  {
> > > > -       int ret = 0;
> > > > -
> > > > -       ret = run_command("sudo ethtool -K %s ntuple off >&2", ifname);
> > > > -       if (ret)
> > > > -               return ret;
> > > > -
> > > > -       return run_command("sudo ethtool -K %s ntuple on >&2", ifname);
> > > > +       run_command("sudo ethtool -K %s ntuple off >&2", ifname);
> > > > +       run_command("sudo ethtool -K %s ntuple on >&2", ifname);
> > > > +       run_command(
> > > > +               "sudo ethtool -n %s | grep 'Filter:' | awk '{print $2}' | xargs -n1 ethtool -N %s delete >&2",
> > > > +               ifname, ifname);
> > > > +       return 0;
> > >
> > > Any reason to remove the checking of the return codes? Silent failures
> > > can waste time if the test fails and someone has to spend time finding
> > > out its the flow steering reset that failed (it may not be very
> > > obvious without the checking of the return code.
> >
> > IIRC, for me the 'ntuple off' part fails because the NIC doesn't let me
> > turn it of. And the new "ethtool .. | grep 'Filter: ' | ..." also fails
> > when there are no existing filters.
> >
> > I will add a comment to clarify..
> 
> Ah, understood. Seems this area is fraught with subtleties.
> 
> If you have time, maybe to counter these subtleties we can do a get of
> ntuple filters and confirm they're 0 somehow at the end of the
> function. That would offset not checking the return code.
> 
> But, I don't think it's extremely likely to run into errors here? So,
> this is probably good and can easily be improved later if we run into
> issues:
> 
> Reviewed-by: Mina Almasry <almasrymina@google.com>

Ack, I'll keep it as is with a comment. Ideally we should do proper
ethtool netlink/ioctl instead of shelling out, but I don' think
ntuple API is exposed to netlink and I'm too lazy to dive into how
the old ioctl-based ntuple API works :-D

