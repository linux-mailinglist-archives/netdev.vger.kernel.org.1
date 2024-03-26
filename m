Return-Path: <netdev+bounces-81992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C01B688C052
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 12:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7D361C2E290
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 11:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867C8481A5;
	Tue, 26 Mar 2024 11:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YUn0nDpW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCAB17C6B
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 11:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711451641; cv=none; b=G0uF7E8yzIwHn89GMYv0p6rw5aq8cny7uqBXkrS3x9Jg4F+eqWP3RZtzH+KZ46KiT4T4lkY85fH2G9k5df1Z2KlsHO6F9CYPm8NSTreP5Qm927y6cmfhny2D5CR53E5KZCAwpgSnHke9J7x/Kotgbd1VjTDlzg8DRpfRGov/r9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711451641; c=relaxed/simple;
	bh=IUDImc0Cjvq+n9tCk3xyPk4DbGsf/olc7JArYvoeISc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cz9PXeoTAftdPp+eBgiB9sJxgMNEe9YIbMjGVr4Hc62KVctWIbiJ+m05nNJCAON+ABgbPcMzfOsKPXiCFYVL+F4uBCt1bFVXDpDLBdvcfTWwQGCNQaszSpri83cKqCI9OF5+o+a8Jp1P5ipQv3I2xgkH8VR92T//sTYml7ddqig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YUn0nDpW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711451638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aBMVJpXt0/WljsLRDk3OHOxG2vFLBZ0ToDUlJHmTpM8=;
	b=YUn0nDpWAJEviXtsozYvbFMyTfFkbSsnKbKmG/t/nwzPXFIrFeSuX4NwODji3xHgMkxj/b
	vpfRbNwqXxL5gB9DcVSlNN5HF71xkHeGUkHPPAeU4OqzFbvWLlwm0linHj0KEGUz1qHkQB
	W+nlBBDYqQxA/rzdGr6rXpRBmHIpJNY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-WI5b--qTOZCqy35ellwV1Q-1; Tue, 26 Mar 2024 07:13:57 -0400
X-MC-Unique: WI5b--qTOZCqy35ellwV1Q-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-341bdc085faso507266f8f.0
        for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 04:13:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711451636; x=1712056436;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aBMVJpXt0/WljsLRDk3OHOxG2vFLBZ0ToDUlJHmTpM8=;
        b=j+HTBzkAZVxqUNpbg9yaV4xuqgDMrc/BTzGbwzMDgokV4Wq0WarjLi2fEpi3v2CwPR
         tHAg6LMf+Gzkg5cC/mmHC4p2u1HBm4+tyk8zoYBYZhrrkin49vX6fYbiegBIWYmJVrIs
         tSGyYqT/qwpXpCimbpP4Z/ArKMyM8diFHgsCiyD7/bllCTY0cEJE2qRjbwEOjWzHYvzD
         vWlnHlXIP55Epcrd3Zm5h/DCK3EYmcFLc1nwH3Bce7YPB1sh6QW9mR2VYPm0WBL6QF6H
         owGoSZn93PKPXNoSzsikurXq5+UkxPWs8Cu32ZjTGnU6cjvm9utQaxcPH38GKq+fDqn9
         cVGw==
X-Forwarded-Encrypted: i=1; AJvYcCVJ0sn/igQq+A3+iSk29Wc7SVzShcMTYRuZ3Oefi5co4xwfOmID9arrO0HjjltXAkPE5E4kXHAG/hOuQEJ0jP0r2b+xA3WK
X-Gm-Message-State: AOJu0Yz00KOeDOjidoe9bi+RbYRC7UfyjDGNob2OHXYJ5kr2STQ98zcC
	+1+t8j8uBS+RakE0GzUfOrzK5NKp45wjBhM6l4nponb8o8HLmYRaCxngqhZ9Gy78Khpv9/gEElH
	Xfuie659BMCHX90s2hOldSBHPajg5w7JegVMsRtFdXQaBBIBbcXSmOQ==
X-Received: by 2002:adf:a4d1:0:b0:33d:9e15:12bf with SMTP id h17-20020adfa4d1000000b0033d9e1512bfmr6700181wrb.3.1711451636062;
        Tue, 26 Mar 2024 04:13:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxhv0v+KQe2Xcx+sEiLWCeammPnh69EDU5f9GIrzeYh7NkyDcICF62zka/71fNz9ySu1hjuA==
X-Received: by 2002:adf:a4d1:0:b0:33d:9e15:12bf with SMTP id h17-20020adfa4d1000000b0033d9e1512bfmr6700162wrb.3.1711451635645;
        Tue, 26 Mar 2024 04:13:55 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-229-159.dyn.eolo.it. [146.241.229.159])
        by smtp.gmail.com with ESMTPSA id z17-20020a056000111100b0033ecbfc6941sm11902527wrw.110.2024.03.26.04.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 04:13:55 -0700 (PDT)
Message-ID: <c0a13d483b1358213747e78ae2fb5542f816afe8.camel@redhat.com>
Subject: Re: [PATCH net-next 0/3] trace: use TP_STORE_ADDRS macro
From: Paolo Abeni <pabeni@redhat.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: edumazet@google.com, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com,  rostedt@goodmis.org, kuba@kernel.org,
 davem@davemloft.net, netdev@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Date: Tue, 26 Mar 2024 12:13:53 +0100
In-Reply-To: <CAL+tcoAW6YxrW7M8io_JHaNm3-VfY_sWZFBg=6XVmYyPAb1Nag@mail.gmail.com>
References: <20240325034347.19522-1-kerneljasonxing@gmail.com>
	 <CAL+tcoAb3Q13hXnEhukCUwBL0Q1W9qC7LuWyzXYGcDzEM56LqA@mail.gmail.com>
	 <b84992bf3953da59e597883e018a79233a09a0bb.camel@redhat.com>
	 <CAL+tcoAW6YxrW7M8io_JHaNm3-VfY_sWZFBg=6XVmYyPAb1Nag@mail.gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=mQINBGISiDUBEAC5uMdJicjm3ZlWQJG4u2EU1EhWUSx8IZLUTmEE8zmjPJFSYDcjtfGcbzLPb63BvX7FADmTOkO7gwtDgm501XnQaZgBUnCOUT8qv5MkKsFH20h1XJyqjPeGM55YFAXc+a4WD0YyO5M0+KhDeRLoildeRna1ey944VlZ6Inf67zMYw9vfE5XozBtytFIrRyGEWkQwkjaYhr1cGM8ia24QQVQid3P7SPkR78kJmrT32sGk+TdR4YnZzBvVaojX4AroZrrAQVdOLQWR+w4w1mONfJvahNdjq73tKv51nIpu4SAC1Zmnm3x4u9r22mbMDr0uWqDqwhsvkanYmn4umDKc1ZkBnDIbbumd40x9CKgG6ogVlLYeJa9WyfVMOHDF6f0wRjFjxVoPO6p/ZDkuEa67KCpJnXNYipLJ3MYhdKWBZw0xc3LKiKc+nMfQlo76T/qHMDfRMaMhk+L8gWc3ZlRQFG0/Pd1pdQEiRuvfM5DUXDo/YOZLV0NfRFU9SmtIPhbdm9cV8Hf8mUwubihiJB/9zPvVq8xfiVbdT0sPzBtxW0fXwrbFxYAOFvT0UC2MjlIsukjmXOUJtdZqBE3v3Jf7VnjNVj9P58+MOx9iYo8jl3fNd7biyQWdPDfYk9ncK8km4skfZQIoUVqrWqGDJjHO1W9CQLAxkfOeHrmG29PK9tHIwARAQABtB9QYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+iQJSBBMBCAA8FiEEg1AjqC77wbdLX2LbKSR5jcyPE6QFAmISiDUCGwMFCwkIBwIDIgIBBhUKCQgLAgQWAgMBAh4HAheAAAoJECkkeY3MjxOkJSYQAJcc6MTsuFxYdYZkeWjW//zbD3ApRHzpNlHLVSuJqHr9/aDS+tyszgS8jj9MiqALzgq4iZbg
 7ZxN9ZsDL38qVIuFkSpgMZCiUHdxBC11J8nbBSLlpnc924UAyr5XrGA99 6Wl5I4Km3128GY6iAkH54pZpOmpoUyBjcxbJWHstzmvyiXrjA2sMzYjt3Xkqp0cJfIEekOi75wnNPofEEJg28XPcFrpkMUFFvB4Aqrdc2yyR8Y36rbw18sIX3dJdomIP3dL7LoJi9mfUKOnr86Z0xltgcLPGYoCiUZMlXyWgB2IPmmcMP2jLJrusICjZxLYJJLofEjznAJSUEwB/3rlvFrSYvkKkVmfnfro5XEr5nStVTECxfy7RTtltwih85LlZEHP8eJWMUDj3P4Q9CWNgz2pWr1t68QuPHWaA+PrXyasDlcRpRXHZCOcvsKhAaCOG8TzCrutOZ5NxdfXTe3f1jVIEab7lNgr+7HiNVS+UPRzmvBc73DAyToKQBn9kC4jh9HoWyYTepjdcxnio0crmara+/HEyRZDQeOzSexf85I4dwxcdPKXv0fmLtxrN57Ae82bHuRlfeTuDG3x3vl/Bjx4O7Lb+oN2BLTmgpYq7V1WJPUwikZg8M+nvDNcsOoWGbU417PbHHn3N7yS0lLGoCCWyrK1OY0QM4EVsL3TjOfUtCNQYW9sbyBBYmVuaSA8cGFvbG8uYWJlbmlAZ21haWwuY29tPokCUgQTAQgAPBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEoitAhsDBQsJCAcCAyICAQYVCgkICwIEFgIDAQIeBwIXgAAKCRApJHmNzI8TpBzHD/45pUctaCnhee1vkQnmStAYvHmwrWwIEH1lzDMDCpJQHTUQOOJWDAZOFnE/67bxSS81Wie0OKW2jvg1ylmpBA0gPpnzIExQmfP72cQ1TBoeVColVT6Io35BINn+ymM7c0Bn8RvngSEpr3jBtqvvWXjvtnJ5/HbOVQCg62NC6ewosoKJPWpGXMJ9SKsVIOUHsmoWK60spzeiJoSmAwm3zTJQnM5kRh2q
 iWjoCy8L35zPqR5TV+f5WR5hTVCqmLHSgm1jxwKhPg9L+GfuE4d0SWd84y GeOB3sSxlhWsuTj1K6K3MO9srD9hr0puqjO9sAizd0BJP8ucf/AACfrgmzIqZXCfVS7jJ/M+0ic+j1Si3yY8wYPEi3dvbVC0zsoGj9n1R7B7L9c3g1pZ4L9ui428vnPiMnDN3jh9OsdaXeWLvSvTylYvw9q0DEXVQTv4/OkcoMrfEkfbXbtZ3PRlAiddSZA5BDEkkm6P9KA2YAuooi1OD9d4MW8LFAeEicvHG+TPO6jtKTacdXDRe611EfRwTjBs19HmabSUfFcumL6BlVyceIoSqXFe5jOfGpbBevTZtg4kTSHqymGb6ra6sKs+/9aJiONs5NXY7iacZ55qG3Ib1cpQTps9bQILnqpwL2VTaH9TPGWwMY3Nc2VEc08zsLrXnA/yZKqZ1YzSY9MGXWYLkCDQRiEog1ARAAyXMKL+x1lDvLZVQjSUIVlaWswc0nV5y2EzBdbdZZCP3ysGC+s+n7xtq0o1wOvSvaG9h5q7sYZs+AKbuUbeZPu0bPWKoO02i00yVoSgWnEqDbyNeiSW+vI+VdiXITV83lG6pS+pAoTZlRROkpb5xo0gQ5ZeYok8MrkEmJbsPjdoKUJDBFTwrRnaDOfb+Qx1D22PlAZpdKiNtwbNZWiwEQFm6mHkIVSTUe2zSemoqYX4QQRvbmuMyPIbwbdNWlItukjHsffuPivLF/XsI1gDV67S1cVnQbBgrpFDxN62USwewXkNl+ndwa+15wgJFyq4Sd+RSMTPDzDQPFovyDfA/jxN2SK1Lizam6o+LBmvhIxwZOfdYH8bdYCoSpqcKLJVG3qVcTwbhGJr3kpRcBRz39Ml6iZhJyI3pEoX3bJTlR5Pr1Kjpx13qGydSMos94CIYWAKhegI06aTdvvuiigBwjngo/Rk5S+iEGR5KmTqGyp27o6YxZy6D4NIc6PKUzhIUxfvuHNvfu
 sD2W1U7eyLdm/jCgticGDsRtweytsgCSYfbz0gdgUuL3EBYN3JLbAU+UZpy v/fyD4cHDWaizNy/KmOI6FFjvVh4LRCpGTGDVPHsQXaqvzUybaMb7HSfmBBzZqqfVbq9n5FqPjAgD2lJ0rkzb9XnVXHgr6bmMRlaTlBMAEQEAAYkCNgQYAQgAIBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEog1AhsMAAoJECkkeY3MjxOkY1YQAKdGjHyIdOWSjM8DPLdGJaPgJdugHZowaoyCxffilMGXqc8axBtmYjUIoXurpl+f+a7S0tQhXjGUt09zKlNXxGcebL5TEPFqgJTHN/77ayLslMTtZVYHE2FiIxkvW48yDjZUlefmphGpfpoXe4nRBNto1mMB9Pb9vR47EjNBZCtWWbwJTIEUwHP2Z5fV9nMx9Zw2BhwrfnODnzI8xRWVqk7/5R+FJvl7s3nY4F+svKGD9QHYmxfd8Gx42PZc/qkeCjUORaOf1fsYyChTtJI4iNm6iWbD9HK5LTMzwl0n0lL7CEsBsCJ97i2swm1DQiY1ZJ95G2Nz5PjNRSiymIw9/neTvUT8VJJhzRl3Nb/EmO/qeahfiG7zTpqSn2dEl+AwbcwQrbAhTPzuHIcoLZYV0xDWzAibUnn7pSrQKja+b8kHD9WF+m7dPlRVY7soqEYXylyCOXr5516upH8vVBmqweCIxXSWqPAhQq8d3hB/Ww2A0H0PBTN1REVw8pRLNApEA7C2nX6RW0XmA53PIQvAP0EAakWsqHoKZ5WdpeOcH9iVlUQhRgemQSkhfNaP9LqR1XKujlTuUTpoyT3xwAzkmSxN1nABoutHEO/N87fpIbpbZaIdinF7b9srwUvDOKsywfs5HMiUZhLKoZzCcU/AEFjQsPTATACGsWf3JYPnWxL9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-03-26 at 18:43 +0800, Jason Xing wrote:
> On Tue, Mar 26, 2024 at 6:29=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >=20
> > On Tue, 2024-03-26 at 12:14 +0800, Jason Xing wrote:
> > > On Mon, Mar 25, 2024 at 11:43=E2=80=AFAM Jason Xing <kerneljasonxing@=
gmail.com> wrote:
> > > >=20
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >=20
> > > > Using the macro for other tracepoints use to be more concise.
> > > > No functional change.
> > > >=20
> > > > Jason Xing (3):
> > > >   trace: move to TP_STORE_ADDRS related macro to net_probe_common.h
> > > >   trace: use TP_STORE_ADDRS() macro in inet_sk_error_report()
> > > >   trace: use TP_STORE_ADDRS() macro in inet_sock_set_state()
> > > >=20
> > > >  include/trace/events/net_probe_common.h | 29 ++++++++++++++++++++
> > > >  include/trace/events/sock.h             | 35 ++++-----------------=
----
> > >=20
> > > I just noticed that some trace files in include/trace directory (like
> > > net_probe_common.h, sock.h, skb.h, net.h, sock.h, udp.h, sctp.h,
> > > qdisc.h, neigh.h, napi.h, icmp.h, ...) are not owned by networking
> > > folks while some files (like tcp.h) have been maintained by specific
> > > maintainers/experts (like Eric) because they belong to one specific
> > > area. I wonder if we can get more networking guys involved in net
> > > tracing.
> > >=20
> > > I'm not sure if 1) we can put those files into the "NETWORKING
> > > [GENERAL]" category, or 2) we can create a new category to include
> > > them all.
> >=20
> > I think all the file you mentioned are not under networking because of
> > MAINTAINER file inaccuracy, and we could move there them accordingly.
>=20
> Yes, they are not under the networking category currently. So how
> could we move them? The MAINTAINER file doesn't have all the specific
> categories which are suitable for each of the trace files.

I think there is no need to other categories: adding the explicit 'F:'
entries for such files in the NETWORKING [GENERAL] section should fit.

> > > I know people start using BPF to trace them all instead, but I can se=
e
> > > some good advantages of those hooks implemented in the kernel, say:
> > > 1) help those machines which are not easy to use BPF tools.
> > > 2) insert the tracepoint in the middle of some functions which cannot
> > > be replaced by bpf kprobe.
> > > 3) if we have enough tracepoints, we can generate a timeline to
> > > know/detect which flow/skb spends unexpected time at which point.
> > > ...
> > > We can do many things in this area, I think :)
> > >=20
> > > What do you think about this, Jakub, Paolo, Eric ?
> >=20
> > I agree tracepoints are useful, but I think the general agreement is
> > that they are the 'old way', we should try to avoid their
> > proliferation.
>=20
> Well, it's a pity that it seems that we are about to abandon this
> method but it's not that friendly to the users who are unable to
> deploy BPF... Well, I came up with more ideas about how to improve the
> trace function in recent days. The motivation of doing this is that I
> encountered some issues which could be traced/diagnosed by using trace
> effortlessly without writing some bpftrace codes again and again. The
> status of trace seems not active but many people are still using it, I
> believe.

I don't think we should abandon it completely. My understanding is that
we should thing carefully before adding new tracepoints, and generally
speaking, avoid adding 'too many' of them.

Cheers,

Paolo



