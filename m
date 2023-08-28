Return-Path: <netdev+bounces-30976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9D578A514
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 07:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D8B7280DE4
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 05:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68087809;
	Mon, 28 Aug 2023 05:06:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D6E7ED
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 05:06:31 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBB8126
	for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 22:06:28 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99bf3f59905so347983166b.3
        for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 22:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693199187; x=1693803987;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6D6JAZ/JA00j7W09g1xJqIX9kfKMl1/EjqDZT54j3Q=;
        b=AdPAMvQbn4cqqWcstkH5PcLwkelrNWzOYbnxvBRX0W8rvLskaaIdHtlwrEXYxXJ6ob
         zKBr2mwkuLKbnA552OaSxka2w9U5KVE37DFGuGP0cFof5d3g9YNC4cpFzRIZMZjIyozR
         QRJckZ6loK4wq2t8bdgQA+IBsLhV2DaHDsB8M8AOtcdCU3AWI9eb8M7qCul1wwV9ovT6
         bQd85cuO0Punu2emfwRtqCwJCIO2iXHN6IatQ26+EHXSxPZzY2mbmI/deF43XhWQOfvM
         XqmwECyVfPygkYu9PsX5LG5jklIJOYypkBE3YWt1xRVRHl5PqhqTgdF4gg86lkHhXR21
         KSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693199187; x=1693803987;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K6D6JAZ/JA00j7W09g1xJqIX9kfKMl1/EjqDZT54j3Q=;
        b=PFb6Tr4VDpRDnnzY0Bh14a9tXsuWOl6SG+4XXtGB0MYeF9Mv/e5jbtqbOkmmIwep4N
         HRruj3lUW+ky4hP4if7N+qfAEJKdxrA3Q+it50NiqW+jVw65BtwwrRfaxnvZNz6w3cx7
         I9zdPlf2aLP8xAssmkUdw6TbNYmcIC8EQkd2LrN+1rIjTV+FQ+WRqt4a5Nd7noJjYd4v
         54fMKfeuSxpkqLPSTR4r06HpiTA+Kq35TMwonW9gIv4ilvj8mpR575uvoW2RTPwmBnZt
         oc/0ptzZ4xDyfJXvneaTDesIG/sBWheWvCdbBWGLrTYvAbYtWSxelUHwdxD/ftzAz7E2
         xlNA==
X-Gm-Message-State: AOJu0YzRdwFLxrciK+W2WNzyH0LkWVWG5lCSC94jGqWWUG9vKSIqfCGr
	HahpksSoCcqClWrOYBfS9mU=
X-Google-Smtp-Source: AGHT+IHwy4Y7vi6jCqMBmvc5RaHd7JqzP62BHzMz8GMdoH/y2F4XoENJC93vR18Qj54HpVMvpPMnnQ==
X-Received: by 2002:a17:906:3199:b0:9a2:276d:d83c with SMTP id 25-20020a170906319900b009a2276dd83cmr7098062ejy.18.1693199186623;
        Sun, 27 Aug 2023 22:06:26 -0700 (PDT)
Received: from smtpclient.apple ([178.254.237.20])
        by smtp.gmail.com with ESMTPSA id u4-20020a170906108400b0099d798a6bb5sm4183012eju.67.2023.08.27.22.06.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Aug 2023 22:06:26 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: High Cpu load when run smartdns : __ipv6_dev_get_saddr
From: Martin Zaharinov <micron10@gmail.com>
In-Reply-To: <a576811a-91ca-9153-afd8-c9738d6eb92b@kernel.org>
Date: Mon, 28 Aug 2023 08:06:15 +0300
Cc: netdev <netdev@vger.kernel.org>,
 Eric Dumazet <edumazet@google.com>,
 pymumu@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <5BE82D57-6948-448D-ABA4-64AF2849944B@gmail.com>
References: <164ECEA1-0779-4EB8-8B2B-387F7CEC7A89@gmail.com>
 <b82afbaf-c548-5b7e-8853-12c3e6a8f757@kernel.org>
 <4898B1F7-2EB5-4182-9D8D-FC8FC780E9B7@gmail.com>
 <a576811a-91ca-9153-afd8-c9738d6eb92b@kernel.org>
To: David Ahern <dsahern@kernel.org>
X-Mailer: Apple Mail (2.3731.700.6)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi David


> On 28 Aug 2023, at 5:42, David Ahern <dsahern@kernel.org> wrote:
>=20
> On 8/27/23 1:17 PM, Martin Zaharinov wrote:
>> Hi David,
>>=20
>>=20
>>=20
>>> On 27 Aug 2023, at 19:51, David Ahern <dsahern@kernel.org> wrote:
>>>=20
>>> On 8/27/23 7:20 AM, Martin Zaharinov wrote:
>>>> Hi Eric=20
>>>>=20
>>>>=20
>>>> i need you help to find is this bug or no.
>>>>=20
>>>> I talk with smartdns team and try to research in his code but for =
the moment not found ..
>>>>=20
>>>> test system have 5k ppp users on pppoe device
>>>>=20
>>>> after run smartdns =20
>>>>=20
>>>> service got to 100% load=20
>>>>=20
>>>> in normal case when run other 2 type of dns server (isc bind or =
knot ) all is fine .
>>>>=20
>>>> but when run smartdns  see perf :=20
>>>>=20
>>>>=20
>>>> PerfTop:    4223 irqs/sec  kernel:96.9%  exact: 100.0% lost: 0/0 =
drop: 0/0 [4000Hz cycles],  (target_pid: 1208268)
>>>> =
--------------------------------------------------------------------------=
--------------------------------------------------------------------------=
-----------------------------------------------------------
>>>>=20
>>>>   28.48%  [kernel]        [k] __ipv6_dev_get_saddr
>>>>   12.31%  [kernel]        [k] l3mdev_master_ifindex_rcu
>>>>    6.63%  [pppoe]         [k] pppoe_rcv
>>>>    3.82%  [kernel]        [k] ipv6_dev_get_saddr
>>>>    2.07%  [kernel]        [k] __dev_queue_xmit
>>>=20
>>> Can you post stack traces for the top 5 symbols?
>>=20
>> If write how i will get.
>=20
> While running traffic load:
>    perf record -a -g -- sleep 5
>    perf report --stdio
>=20


Here is perf.data file : https://easyupload.io/k3ep8l



>>=20
>>>=20
>>> What is the packet rate when the above is taken?
>>=20
>> its normal rate of dns query=E2=80=A6 with both other dns server all =
is fine=20
>=20
> That means nothing to me. You will need to post packet rates.

I honestly don't know how to measure it, but I don't think they are more =
than 10k QPS - in system have 5-5.5k users=20

>=20
>>=20
>>>=20
>>> 4,223 irqs/sec is not much of a load; can you add some details on =
the
>>> hardware and networking setup (e.g., l3mdev reference suggests you =
are
>>> using VRF)?
>> No system is very simple:
>>=20
>> eth0 (Internet) Router (smartDNS + pppoe server ) - eth1 ( User side =
with pppoe server ) here have 5000 ppp interface .
>>=20
>> with both other service i dont see all work fine.
>=20
> ip link sh type vrf
> --> that does not show any devices? It should because the majority of
> work done in l3mdev_master_ifindex_rcu is for vrf port devices. ie., =
it
> should not appear in the perf-top data you posted unless vrf devices =
are
> in play.

VRF is disable in kernel config .





