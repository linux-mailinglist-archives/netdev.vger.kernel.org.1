Return-Path: <netdev+bounces-97514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6F28CBD0F
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 10:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F9B11C22091
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 08:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9361A7D41C;
	Wed, 22 May 2024 08:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hz358NO5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6CC7AE5D
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 08:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716366970; cv=none; b=XVD9vyfr4SGQQWdFKiCN0ZPkR3LLJtnuQCYbChpTJBIBW7CQsIIqjvCAi2uX89TyNG4BK2l8j16wDPdjKlDcvFwW9i2p4ubXaR8KM5H/78c5RMO6B+pLeCBkX16sC7/Wr7aMKef/JL5xT9RFJIETwIUE2z56Dwn4e+n/k5iFYNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716366970; c=relaxed/simple;
	bh=9L2OvoJLjraOVyzTIjA4CN+PDlEVjz+9OLCKeUp8muE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j2bXxj1RE8lPRJAtYM7gTzYHNVkSHUzzsk9LVrgqI/9CIa38DjXRF2FWyxaoMxH9v0xzcIlTHH+9PHX4qXOH7Fh1kOroCyuZMlkSrPX8YPkO3xSLYWCvhL4H/scLJhHNPZSEG2XREK7smX0gNNy0VJ5FTAXHGibChQ8k9nfxr8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hz358NO5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716366967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9L2OvoJLjraOVyzTIjA4CN+PDlEVjz+9OLCKeUp8muE=;
	b=Hz358NO53jzfQ8ctcp9pVlQq4akVDvegixzKTKf8/+4lA1XLyaFxFZhPq8rz9eFso0gL60
	eislcG8aI655lSE+rcbJ4SuxqRroxDPdAB0d8and6vRAJCgFT/WFoRQF4LuQOt5F0s+zpq
	w+dfJ5cLqCAjgdlTNwrDapZK72VWAOM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-74-YsmASN3-m6MAgEoVoWg-1; Wed, 22 May 2024 04:36:06 -0400
X-MC-Unique: 74-YsmASN3-m6MAgEoVoWg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-354e237b6b9so28983f8f.3
        for <netdev@vger.kernel.org>; Wed, 22 May 2024 01:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716366965; x=1716971765;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9L2OvoJLjraOVyzTIjA4CN+PDlEVjz+9OLCKeUp8muE=;
        b=oupbs7axjoY/Ms/L29KAmWvqYn2ODi8L45KRrmayy7IH+Tn4XtZTP9cSQVvEX32zp9
         LSkZBJeSKf413ZRfviRfwBplBydWF4MoTkY9Jg/UMaXKWmFpN1z9hK5CKPdIyJurwssS
         LC8H+DCu43pjaDgN1MVeO+Waifi2LjEeidnNQ1nhbSjVx+JzhGoe6ArNTcDHtRHk3sZQ
         01kkllAQIHFNilNJOR+FZBML18p2MRW1+Kx5bx9NuJYJCSlVqPwhyMqXxms7ZpNc8aYo
         0n8kSd9qMMp4sX849HV3ejLfCmvry9QnXQMTu5trOz2o2vAEPL2ZDdk/XlPeLAORNA0p
         8Hbw==
X-Forwarded-Encrypted: i=1; AJvYcCXg7/obZxCryUumXWxbVOg5S+ersdlxRc6uNscvS+k63MUKCwNMK3UUxMAw+RSlD3HV8V8FXhywuAHhfUdtb/hUTTwW/snm
X-Gm-Message-State: AOJu0YxAOpxFbOZx+Dj5tUnefu56lXCYG7b00NlRtB4ysA3+LtYIecJ7
	1f0bGwfXCcmaEK2z1R/B9jRlRwDV0yr5gl74xeY8/jb7ROSZtg3Ph/GNtHWZUkqsJgtjoml4FCw
	Id0PjszVfpwOBEH/NStfHKuw8lsojCkHdDBzEGLUKRljr+/QPEncVhmMOiAsA2g==
X-Received: by 2002:adf:ca83:0:b0:354:cc58:26cc with SMTP id ffacd0b85a97d-354d8c787fdmr727598f8f.1.1716366965085;
        Wed, 22 May 2024 01:36:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHov+dH19YKlQkwp3hyje4cPFeKnZn2zKh+HDRDsHBLqY7dZvSBW7dsYS8XkVDlXGr2gAVGYg==
X-Received: by 2002:adf:ca83:0:b0:354:cc58:26cc with SMTP id ffacd0b85a97d-354d8c787fdmr727589f8f.1.1716366964697;
        Wed, 22 May 2024 01:36:04 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b094:ab10::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-354c4e68a55sm8002507f8f.10.2024.05.22.01.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 01:36:04 -0700 (PDT)
Message-ID: <d208bf59246120f47c4366ddf9b88431c761dba8.camel@redhat.com>
Subject: Re: [PATCH v2] net: mhi: set skb mac header before entering RX path
From: Paolo Abeni <pabeni@redhat.com>
To: Martin =?ISO-8859-1?Q?F=E4cknitz?= <faecknitz@hotsplots.de>, 
	netdev@vger.kernel.org
Cc: mhi@lists.linux.dev
Date: Wed, 22 May 2024 10:36:02 +0200
In-Reply-To: <20240517211909.27874-1-faecknitz@hotsplots.de>
References: <20240517211909.27874-1-faecknitz@hotsplots.de>
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

On Fri, 2024-05-17 at 23:19 +0200, Martin F=C3=A4cknitz wrote:
> skb->mac_header must be set before passing the skb to the network stack,
> because skb->mac_len is calculated from skb->mac_header in
> __netif_receive_skb_core.
>=20
> Some network stack components, like xfrm, are using skb->mac_len to
> check for an existing MAC header, which doesn't exist in this case. This
> leads to memory corruption.
>=20
> Fixes: 7ffa7542eca6 ("net: mhi: Remove MBIM protocol")

I'm possibly missing something, but the above tag looks incorrect:
AFAICS the mac header was not set even before such commit for the non
WWAN case.

Thanks,

Paolo


