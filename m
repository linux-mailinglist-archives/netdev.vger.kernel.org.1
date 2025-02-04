Return-Path: <netdev+bounces-162477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E10BA27024
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 12:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AABDC1621AE
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 11:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CDC20ADD6;
	Tue,  4 Feb 2025 11:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h4Lnws47"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEBD2063E1
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 11:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738668070; cv=none; b=qiTvK4sAo8jzWku4zLP3xsED7FTx3jyKUiKSfOa7LEgdr1OAPJ7WY3Ys0KVjxf9AU6tZf1hvlh0lBkMS1wxIJih7WPwB6ToFfvT+Bh3uYJY3ImsXRbqsl685NTsIxCdOzr7Sr6i0a7CrOQ8L0ptN2sWA1M89bjPCVIXLmb0T6Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738668070; c=relaxed/simple;
	bh=k5qEvK82+GR5FBukEwNNRAUagwWluztOs0CuTBv95cw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kdPeDyL0jwUpiwibEprot2EtDrUmYaUCiLu3LLhElCD8YFLVSreIdP3Jui83NY5CmAntwWLdWSIrlJwB1C85RNi9gMJaslsjpFra4mdfD7TGbOysRP0bmJf1xNyD/+XrCK5WLdGLmPK8UGKiaYhj4kEUJioQGVcWs6BFmDPuVLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h4Lnws47; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738668067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k5qEvK82+GR5FBukEwNNRAUagwWluztOs0CuTBv95cw=;
	b=h4Lnws4796wUE355N/3VbyfScB/OKF+9sj2ptmslJBTsvtKgPoI6c/7uEsNpyQLHJKsV1K
	5PW6oJ8aZU8bC6uIx/BcKZJFYBC++7ee2RwK7Fa/zReCLar0YBxr5k3ay69+rWrBAspNCi
	RZ06qotoOWIkVboRXkUxvI1LdXBG1h4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-2wYG9F1QOJ6GUQHPmN9mKw-1; Tue, 04 Feb 2025 06:21:06 -0500
X-MC-Unique: 2wYG9F1QOJ6GUQHPmN9mKw-1
X-Mimecast-MFC-AGG-ID: 2wYG9F1QOJ6GUQHPmN9mKw
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ab6d5363a4bso696499966b.3
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 03:21:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738668065; x=1739272865;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k5qEvK82+GR5FBukEwNNRAUagwWluztOs0CuTBv95cw=;
        b=l1aq5PYQGiax8S0FUHrHz5L9R5elR9W177Kal9onafhSljy+SzdKTf0ECE/q7ns4AN
         +WG2atDprT1IbzvYnewFvV7y8ingjSOclCxjXdJuwqSwgGQnHdiLoo41ow5NXdjDDRWi
         C5YH+m33YUqyKIBqVbt2MYOoJbY/67knvZ43psfoN8IdIEaH6OiMevJoXYZ4rfbNb4pw
         xXFVs/0z17EaWj7oyix8XtR8G0B+E4Yv00bwUxTnVYMct6hRV/XAZxiUWJ5xtycm97Lp
         OcNS4og5rD53edDYLTVWfhVT19KbmzmbPpRIkLh5S2Q/jwwVVfw5yjJTlhr36FHfnevZ
         vlcA==
X-Forwarded-Encrypted: i=1; AJvYcCVlkNY9ictkFmXXwhE1QsjhFhtttK4vTFj/qjIpj13uBCCXWMTxq70LBkAKX9SQD7b0ZC0cXLI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0zaEK/9B0hOCWZ8U8sKUxjFD6vwd5RCDbddqjNrZtNb/R1UBc
	Ug8tjhPHykpTj3bduEh4zFl6Qv4m7i6unbfn3u43bCStQk7tH3J4Lms7A3X66nqmlh2UgFUXenV
	9+UOj3KUUvcspDbz4vF9qB6ki9fBuEXuXmbFDImY6eSNZ8+Ehl4T8uYch3ihJJQ==
X-Gm-Gg: ASbGncscFXyzq6A7lgTIkz6PUkqq/GHEkMnqh5sWQpqluSCPu46GzxowYoUrb8V7Yn7
	bwyEnhdXKvo+ev8ttGZCPYworEtERStLrkzwFMS2TVvhSDs0MjAraccCtIzkklr8Dtjsr9/CS8b
	v1YFPnqrQt0D68yZH4IC/+uu1uMkcfImcCeIGcgroZ3f1RJ30Vj42+bCP8U1iouLWUrIdJv4Fqz
	5cFw2q5IjVq90K9vvVagqZ3w9bXlFbevJSSBwF94vl6zuLs3TQ2pY56RVRUoKMnec/OHvU5IGeh
	tg==
X-Received: by 2002:a17:907:9691:b0:ab6:dbd2:df78 with SMTP id a640c23a62f3a-ab6dbd2e39dmr2840611766b.35.1738668064798;
        Tue, 04 Feb 2025 03:21:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAJS08rkvj3lmcvnSV+w1UiCxk/Ec3Wlq0zFzDWOdK/iu7uYP6eGQ3XURyzP48BuNlb/AMLA==
X-Received: by 2002:a17:907:9691:b0:ab6:dbd2:df78 with SMTP id a640c23a62f3a-ab6dbd2e39dmr2840609466b.35.1738668064380;
        Tue, 04 Feb 2025 03:21:04 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e4a3072asm905905066b.130.2025.02.04.03.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 03:21:03 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id EBA87180BC65; Tue, 04 Feb 2025 12:20:56 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: netdevsim: Support setting dev->perm_addr
In-Reply-To: <20250203143958.6172c5cd@kernel.org>
References: <20250203-netdevsim-perm_addr-v1-1-10084bc93044@redhat.com>
 <20250203143958.6172c5cd@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 04 Feb 2025 12:20:56 +0100
Message-ID: <871pweymzr.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> writes:

> On Mon, 03 Feb 2025 18:21:24 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Network management daemons that match on the device permanent address
>> currently have no virtual interface types to test against.
>> NetworkManager, in particular, has carried an out of tree patch to set
>> the permanent address on netdevsim devices to use in its CI for this
>> purpose.
>>=20
>> To support this use case, add a debugfs file for netdevsim to set the
>> permanent address to an arbitrary value.
>
> netdevsim is not for user space testing. We have gone down the path
> of supporting random features in it already, and then wasted time trying
> to maintain them thru various devlink related perturbations, just to
> find out that the features weren't actually used any more.
>
> NetworkManager can do the HW testing using virtme-ng.

Sorry if I'm being dense, but how would that work? What device type
would one create inside a virtme-ng environment that would have a
perm_addr set?

> If you want to go down the netdevsim path you must provide a meaningful=20
> in-tree test, but let's be clear that we will 100% delete both the test
> and the netdevsim functionality if it causes any issues.

Can certainly add a test case, sure! Any preference for where to put it?
Somewhere in selftests/net, I guess, but where? rtnetlink.sh and
bpf_offload.py seem to be the only files currently doing anything with
netdevsim. I could add a case to the former?

-Toke


