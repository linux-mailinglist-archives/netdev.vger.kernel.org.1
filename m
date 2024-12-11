Return-Path: <netdev+bounces-151239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE379ED999
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 23:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9E911885F02
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 22:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93381F0E50;
	Wed, 11 Dec 2024 22:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DxJT5G3B"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399CC1EC4CD
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 22:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733955893; cv=none; b=X+o+CkaIoUv/UURi/G5KS0rNZL9bZP7wEZZx+E6J87ERBXpzJwByPykGLXKSbGkl8sPDCZNdIDtGgfu3TL4YT+JGHa2PKRskLvdmRgrZ0GDTe0wdqEyLJkyqZa2fY2tw7mGtX/ATUQR0ic2CYScSH0gS7f3kXYT5ooYFCNHTT6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733955893; c=relaxed/simple;
	bh=RV/W/MroeiS9i7sZw8kk7loBgZRFz63mwAfHWQtoXlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UtIZeXyqNOq/IMSFG74NbilrnXRH+SLeWN4mSQRivZPNm3s9KbA24vVtyWULuVApGhylpq8QrpcOEKSBEiti9q7EpqV8vhoBl4tGA2N1PA678DWlQJ3lwb0Yp2t1O067bXGoV22m6b70mhBVUx9QgXnNs/AKnJAhiEz9G4d+2mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DxJT5G3B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733955890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4L62xxnOjfKCwQHQtFYxaSuIGZjtEixLHzI3Spv7u9I=;
	b=DxJT5G3Bm88gTE25/B/XJpT4WqEks49r6GDDl+WxkvIvhr0fPDrovpW5F72RjJQ655K8AB
	TguYPHMbqmMEobuNGYfRkFKy+hyF6XbRMCcCGFNK7QNBN6cTfQXsC1lEvvXpsah7PRbbzF
	NLuZjhuYJzKfVg+vfgEkCAwWnrMp+gY=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-a_N0ztx9P92O0Sj8VNLW4g-1; Wed, 11 Dec 2024 17:24:49 -0500
X-MC-Unique: a_N0ztx9P92O0Sj8VNLW4g-1
X-Mimecast-MFC-AGG-ID: a_N0ztx9P92O0Sj8VNLW4g
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-6ef88388aaaso85077197b3.0
        for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 14:24:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733955888; x=1734560688;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4L62xxnOjfKCwQHQtFYxaSuIGZjtEixLHzI3Spv7u9I=;
        b=a1JqomuTZrY3yxfzmmrO/6VtANTnRZLlR83niTrLOoeRi+LLhZ20rn9waArmjk8ffO
         jAfImz1zAbXoV0bJhyzAYfP9471LHMNocxPKz+d6cttTqIKsc9LKkInf/2J+C1aSvfZ5
         UC7ax8zxH8vEXW1XJbXcEHQQPfAmIBbmd8giIrMx9LUhYP6BfhJjCLgSlR7jaeM+QIPL
         6iS1sAzJ5eNhkvIpWcD/2Bbr+kLh8y4Oc2DdEdDzEqcr1oBYrSRNFGQHEo8K2LHNPIYU
         BBi/DuAD0ZbsNVl0dLKa93tErWFjiYim9blH2yIviV8hlsmH+WAILcs3g8yBcbxJFEs9
         ymDw==
X-Forwarded-Encrypted: i=1; AJvYcCX1rGlqtpE0bJbv8SyjxeFSWJzOJ7LTu64Uh9tcjntvaPnDPQwKEObP4YVZ3yY+cSqlG33Tn28=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbpx4hvVy4FZAwuj5a6qlfLGrNg2PLR3oWXCJj/Q7OtxIx/8AM
	WGOgqpY5tHONIdtJ02HzNRSPsjI1cwO2QF6ecxvHgYZjKBITBRf+QlnFsAymv368iZH1tsUnhJJ
	wrqAZpFLLZbVuQMOansz8456l8jB2KyoPAUXJSdmTFBF11YXqRkZrT1GCIgylbKL1ZaH+PJgX4n
	5woMwRRTJA4owOkiu/XYWLeaF5ZDPb
X-Gm-Gg: ASbGncs7p+fNJvHEE6mQ38R6NHXqt7d8LdPZbpdfRbFOCBCM1vcR6clFDHC6bPK3Elb
	Er62AngeQolsU8kZLlu3HN1ZSgM7dAm9p+jf7gTpthxi+jabt/C5+vYEKPg9cQVHVMg==
X-Received: by 2002:a05:690c:4485:b0:6e2:2600:ed50 with SMTP id 00721157ae682-6f19e5071a2mr10985187b3.21.1733955888567;
        Wed, 11 Dec 2024 14:24:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGh7oBAib1eBpyek7a5WPWh4QHh7h9VICuRKeigaC7/liBhCsHFKK7GpYF1R309LJITTPHEPKoaTwkJLcRC/qY=
X-Received: by 2002:a05:690c:4485:b0:6e2:2600:ed50 with SMTP id
 00721157ae682-6f19e5071a2mr10985027b3.21.1733955888311; Wed, 11 Dec 2024
 14:24:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210161448.76799-1-donald.hunter@gmail.com>
 <20241210161448.76799-8-donald.hunter@gmail.com> <20241211210713.GE2806@kernel.org>
In-Reply-To: <20241211210713.GE2806@kernel.org>
From: Donald Hunter <donald.hunter@redhat.com>
Date: Wed, 11 Dec 2024 22:24:37 +0000
Message-ID: <CAAf2ycnfaZ9z4+skH9cUFxgx8Dk60ct-WsZXq9YS6gUtY1dQFw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 7/7] netlink: specs: wireless: add a spec for nl80211
To: Simon Horman <horms@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Dec 2024 at 21:13, Simon Horman <horms@kernel.org> wrote:
>
> On Tue, Dec 10, 2024 at 04:14:48PM +0000, Donald Hunter wrote:
> > Add a rudimentary YNL spec for nl80211 that covers get-wiphy,
> > get-interface and get-protocol-features.
> >
> > ./tools/net/ynl/cli.py \
> >     --spec Documentation/netlink/specs/nl80211.yaml \
> >     --do get-protocol-features
> > {'protocol-features': {'split-wiphy-dump'}}
> >
> > ./tools/net/ynl/cli.py \
> >     --spec Documentation/netlink/specs/nl80211.yaml \
> >     --dump get-wiphy --json '{ "split-wiphy-dump": true }'
> >
> > ./tools/net/ynl/cli.py \
> >     --spec Documentation/netlink/specs/nl80211.yaml \
> >     --dump get-interface
> >
> > Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
>
> Hi Donald,
>
> Perhaps I'm doing something silly here, or my environment is somehow
> broken. But with this patch applied I see:
>
> make -C tools/net/ynl/ distclean && make -C tools/net/ynl/
> ...
> Exception: new_attr: unsupported sub-type u32
> make[1]: *** [Makefile:37: nl80211-user.c] Error 1

Hi Simon,

Thanks for reporting. It was also flagged up on patchwork. My bad. I
had a blind spot for checking the C build because the last few specs I
have worked on have been netlink-raw which don't have codegen. I'll
look at fixing this and any subsequent issues.

Thanks,
Donald.


