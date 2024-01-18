Return-Path: <netdev+bounces-64260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CBC831F18
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 19:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 454451C22A38
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 18:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB522D630;
	Thu, 18 Jan 2024 18:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vs0DjMLR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938AA2D7AD
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 18:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705602627; cv=none; b=uxxzETbvyd7+9oFSo4ahIBrv8iXvsQOOuY3/Q+Y9rM7lXS2n6WR/LcOvR+inyCC0oDLKG+dEHJN6PVnYeJariWp0pqVw5EJi/sIOyv74kohgqd6MjMtcWD8/sRGFBbhhrQCNbocHrUMO3AXSRgjgmGqB979GXVPRQqT7GXkXYFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705602627; c=relaxed/simple;
	bh=2om35B1qNrKdlff6CFq+9tlE1T2KKNR1rKB+YeCnty0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jl6F30HJSX9d0WUv8oAE5QD2Td2dvvmFDdchJFaxEcH1+w9eAbdYbaqtHelwwyPrOS1VHXtwnzf3g2KiAj23iUlo4MzsqC+2FMJKF8gmhFM9Ekibp47OqfQUP9q1FY4+ofYoNvPf9L+4e8vIY84a81fpMXteFZw7Hfq1TPrsonE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vs0DjMLR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705602624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ORcUfoaJ+pUbgdPa34cgMn2qENAscd6rFkU3zqloR44=;
	b=Vs0DjMLR3Fd5IwwBxjDDruP4f4jnNCiWjX/3FinwudBhOjeCaDYeAe/tU10e11597qFX2X
	y/Gva3eu4MYQLL9FQluWW4fz9JqpsBjEkkOmZR/HSVcST8d6Q8BfeMyU0TXd+UwOlGcc38
	feNyRoDOt6Cl8fTFcKybhUxNOyqim8A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-uwNnjw8jOP-R6dO1ySs9nw-1; Thu, 18 Jan 2024 13:30:23 -0500
X-MC-Unique: uwNnjw8jOP-R6dO1ySs9nw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40e703adab9so7245295e9.1
        for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 10:30:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705602622; x=1706207422;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ORcUfoaJ+pUbgdPa34cgMn2qENAscd6rFkU3zqloR44=;
        b=kNka27pGmJJFurz4l35a3WLUZNobk6H4fpJ+WTIYhJkH9t3y7kjUaeHQXyYuOgyIA9
         xg9XWs0WC2+ILQ9zLxYMyXEYWW6MmK5OK/lwKUYEO5dHRguxrKOOoIQe0df1UiHAs0k6
         vm5AQ/g2DjZQOS755X0YbhCN6jQbPgypJkY5SyP1t6P+AhDZfw6vwCP9NHzpigLY7yxn
         6KaYMMWTi6WbGBqSqb6jYY7Cw7SoogiozIv47FXEUGlqaxne7W6dBfXSKekYv0YGVfzw
         6MeHQQa8GBHC7xufAFMyEfy16NuXZXT2v45EeB1EVciVpSXzsqIGkSrcyZly/gzbfRUO
         03Jg==
X-Gm-Message-State: AOJu0Ywf6lewkPVEkeozF6ghGz5Vvb7dCIPWym6k4vTVY6mL/qUI+yUG
	KXWhPvykz+rn08YtWqeYlNdU76dvK52TgzxkYXm0EViyE+hK/6WX3SmrtfvELur/3FnGG5+t02m
	9sDCJze3L5Ve2t7p/4/HapPTwlWp5SBN1wMbLNToTNgxIonaOTEAfgw==
X-Received: by 2002:adf:e3d2:0:b0:337:c58a:ac90 with SMTP id k18-20020adfe3d2000000b00337c58aac90mr134014wrm.2.1705602621983;
        Thu, 18 Jan 2024 10:30:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFhf389ghQlRWh6PF0wxh1H8fQIfp/M4rrD7a6AnOrXv3QM+tXdmCrwKYzPI+/XZQ/epaieQ==
X-Received: by 2002:adf:e3d2:0:b0:337:c58a:ac90 with SMTP id k18-20020adfe3d2000000b00337c58aac90mr133999wrm.2.1705602621602;
        Thu, 18 Jan 2024 10:30:21 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-241-180.dyn.eolo.it. [146.241.241.180])
        by smtp.gmail.com with ESMTPSA id z2-20020adff1c2000000b003372b8ab19asm4645784wro.64.2024.01.18.10.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 10:30:21 -0800 (PST)
Message-ID: <82bba704bf0019cc551310c563623092bf01ef8d.camel@redhat.com>
Subject: Re: [PATCH v3] tcp: Add memory barrier to tcp_push()
From: Paolo Abeni <pabeni@redhat.com>
To: Geoff Blake <blakgeof@amazon.com>
Cc: Salvatore Dipietro <dipiets@amazon.com>, edumazet@google.com, 
	alisaidi@amazon.com, benh@amazon.com, davem@davemloft.net, 
	dipietro.salvatore@gmail.com, dsahern@kernel.org, kuba@kernel.org, 
	netdev@vger.kernel.org
Date: Thu, 18 Jan 2024 19:30:19 +0100
In-Reply-To: <1195cf45-9c73-3450-36de-df54224135b6@amazon.com>
References: 
	<CANn89i+XkcQV6_=ysKACN+JQM=P7SqbfTvhxF+jSwd=MJ6t0sw@mail.gmail.com>
	  <20240117231646.22853-1-dipiets@amazon.com>
	 <e69835dd96eb2452b8d4a6b431c7d6100b582acd.camel@redhat.com>
	 <1195cf45-9c73-3450-36de-df54224135b6@amazon.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=mQINBGISiDUBEAC5uMdJicjm3ZlWQJG4u2EU1EhWUSx8IZLUTmEE8zmjPJFSYDcjtfGcbzLPb63BvX7FADmTOkO7gwtDgm501XnQaZgBUnCOUT8qv5MkKsFH20h1XJyqjPeGM55YFAXc+a4WD0YyO5M0+KhDeRLoildeRna1ey944VlZ6Inf67zMYw9vfE5XozBtytFIrRyGEWkQwkjaYhr1cGM8ia24QQVQid3P7SPkR78kJmrT32sGk+TdR4YnZzBvVaojX4AroZrrAQVdOLQWR+w4w1mONfJvahNdjq73tKv51nIpu4SAC1Zmnm3x4u9r22mbMDr0uWqDqwhsvkanYmn4umDKc1ZkBnDIbbumd40x9CKgG6ogVlLYeJa9WyfVMOHDF6f0wRjFjxVoPO6p/ZDkuEa67KCpJnXNYipLJ3MYhdKWBZw0xc3LKiKc+nMfQlo76T/qHMDfRMaMhk+L8gWc3ZlRQFG0/Pd1pdQEiRuvfM5DUXDo/YOZLV0NfRFU9SmtIPhbdm9cV8Hf8mUwubihiJB/9zPvVq8xfiVbdT0sPzBtxW0fXwrbFxYAOFvT0UC2MjlIsukjmXOUJtdZqBE3v3Jf7VnjNVj9P58+MOx9iYo8jl3fNd7biyQWdPDfYk9ncK8km4skfZQIoUVqrWqGDJjHO1W9CQLAxkfOeHrmG29PK9tHIwARAQABtB9QYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+iQJSBBMBCAA8FiEEg1AjqC77wbdLX2LbKSR5jcyPE6QFAmISiDUCGwMFCwkIBwIDIgIBBhUKCQgLAgQWAgMBAh4HAheAAAoJECkkeY3MjxOkJSYQAJcc6MTsuFxYdYZkeWjW//zbD3ApRHzpNlHLVSuJqHr9/aDS+tyszgS8jj9MiqALzgq4iZbg
 7ZxN9ZsDL38qVIuFkSpgMZCiUHdxBC11J8nbBSLlpnc924UAyr5XrGA99 6Wl5I4Km3128GY6iAkH54pZpOmpoUyBjcxbJWHstzmvyiXrjA2sMzYjt3Xkqp0cJfIEekOi75wnNPofEEJg28XPcFrpkMUFFvB4Aqrdc2yyR8Y36rbw18sIX3dJdomIP3dL7LoJi9mfUKOnr86Z0xltgcLPGYoCiUZMlXyWgB2IPmmcMP2jLJrusICjZxLYJJLofEjznAJSUEwB/3rlvFrSYvkKkVmfnfro5XEr5nStVTECxfy7RTtltwih85LlZEHP8eJWMUDj3P4Q9CWNgz2pWr1t68QuPHWaA+PrXyasDlcRpRXHZCOcvsKhAaCOG8TzCrutOZ5NxdfXTe3f1jVIEab7lNgr+7HiNVS+UPRzmvBc73DAyToKQBn9kC4jh9HoWyYTepjdcxnio0crmara+/HEyRZDQeOzSexf85I4dwxcdPKXv0fmLtxrN57Ae82bHuRlfeTuDG3x3vl/Bjx4O7Lb+oN2BLTmgpYq7V1WJPUwikZg8M+nvDNcsOoWGbU417PbHHn3N7yS0lLGoCCWyrK1OY0QM4EVsL3TjOfUtCNQYW9sbyBBYmVuaSA8cGFvbG8uYWJlbmlAZ21haWwuY29tPokCUgQTAQgAPBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEoitAhsDBQsJCAcCAyICAQYVCgkICwIEFgIDAQIeBwIXgAAKCRApJHmNzI8TpBzHD/45pUctaCnhee1vkQnmStAYvHmwrWwIEH1lzDMDCpJQHTUQOOJWDAZOFnE/67bxSS81Wie0OKW2jvg1ylmpBA0gPpnzIExQmfP72cQ1TBoeVColVT6Io35BINn+ymM7c0Bn8RvngSEpr3jBtqvvWXjvtnJ5/HbOVQCg62NC6ewosoKJPWpGXMJ9SKsVIOUHsmoWK60spzeiJoSmAwm3zTJQnM5kRh2q
 iWjoCy8L35zPqR5TV+f5WR5hTVCqmLHSgm1jxwKhPg9L+GfuE4d0SWd84y GeOB3sSxlhWsuTj1K6K3MO9srD9hr0puqjO9sAizd0BJP8ucf/AACfrgmzIqZXCfVS7jJ/M+0ic+j1Si3yY8wYPEi3dvbVC0zsoGj9n1R7B7L9c3g1pZ4L9ui428vnPiMnDN3jh9OsdaXeWLvSvTylYvw9q0DEXVQTv4/OkcoMrfEkfbXbtZ3PRlAiddSZA5BDEkkm6P9KA2YAuooi1OD9d4MW8LFAeEicvHG+TPO6jtKTacdXDRe611EfRwTjBs19HmabSUfFcumL6BlVyceIoSqXFe5jOfGpbBevTZtg4kTSHqymGb6ra6sKs+/9aJiONs5NXY7iacZ55qG3Ib1cpQTps9bQILnqpwL2VTaH9TPGWwMY3Nc2VEc08zsLrXnA/yZKqZ1YzSY9MGXWYLkCDQRiEog1ARAAyXMKL+x1lDvLZVQjSUIVlaWswc0nV5y2EzBdbdZZCP3ysGC+s+n7xtq0o1wOvSvaG9h5q7sYZs+AKbuUbeZPu0bPWKoO02i00yVoSgWnEqDbyNeiSW+vI+VdiXITV83lG6pS+pAoTZlRROkpb5xo0gQ5ZeYok8MrkEmJbsPjdoKUJDBFTwrRnaDOfb+Qx1D22PlAZpdKiNtwbNZWiwEQFm6mHkIVSTUe2zSemoqYX4QQRvbmuMyPIbwbdNWlItukjHsffuPivLF/XsI1gDV67S1cVnQbBgrpFDxN62USwewXkNl+ndwa+15wgJFyq4Sd+RSMTPDzDQPFovyDfA/jxN2SK1Lizam6o+LBmvhIxwZOfdYH8bdYCoSpqcKLJVG3qVcTwbhGJr3kpRcBRz39Ml6iZhJyI3pEoX3bJTlR5Pr1Kjpx13qGydSMos94CIYWAKhegI06aTdvvuiigBwjngo/Rk5S+iEGR5KmTqGyp27o6YxZy6D4NIc6PKUzhIUxfvuHNvfu
 sD2W1U7eyLdm/jCgticGDsRtweytsgCSYfbz0gdgUuL3EBYN3JLbAU+UZpy v/fyD4cHDWaizNy/KmOI6FFjvVh4LRCpGTGDVPHsQXaqvzUybaMb7HSfmBBzZqqfVbq9n5FqPjAgD2lJ0rkzb9XnVXHgr6bmMRlaTlBMAEQEAAYkCNgQYAQgAIBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEog1AhsMAAoJECkkeY3MjxOkY1YQAKdGjHyIdOWSjM8DPLdGJaPgJdugHZowaoyCxffilMGXqc8axBtmYjUIoXurpl+f+a7S0tQhXjGUt09zKlNXxGcebL5TEPFqgJTHN/77ayLslMTtZVYHE2FiIxkvW48yDjZUlefmphGpfpoXe4nRBNto1mMB9Pb9vR47EjNBZCtWWbwJTIEUwHP2Z5fV9nMx9Zw2BhwrfnODnzI8xRWVqk7/5R+FJvl7s3nY4F+svKGD9QHYmxfd8Gx42PZc/qkeCjUORaOf1fsYyChTtJI4iNm6iWbD9HK5LTMzwl0n0lL7CEsBsCJ97i2swm1DQiY1ZJ95G2Nz5PjNRSiymIw9/neTvUT8VJJhzRl3Nb/EmO/qeahfiG7zTpqSn2dEl+AwbcwQrbAhTPzuHIcoLZYV0xDWzAibUnn7pSrQKja+b8kHD9WF+m7dPlRVY7soqEYXylyCOXr5516upH8vVBmqweCIxXSWqPAhQq8d3hB/Ww2A0H0PBTN1REVw8pRLNApEA7C2nX6RW0XmA53PIQvAP0EAakWsqHoKZ5WdpeOcH9iVlUQhRgemQSkhfNaP9LqR1XKujlTuUTpoyT3xwAzkmSxN1nABoutHEO/N87fpIbpbZaIdinF7b9srwUvDOKsywfs5HMiUZhLKoZzCcU/AEFjQsPTATACGsWf3JYPnWxL9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-01-18 at 11:46 -0600, Geoff Blake wrote:
>=20
> On Thu, 18 Jan 2024, Paolo Abeni wrote:
>=20
> > CAUTION: This email originated from outside of the organization. Do not=
 click links or open attachments unless you can confirm the sender and know=
 the content is safe.
> >=20
> >=20
> >=20
> > On Wed, 2024-01-17 at 15:16 -0800, Salvatore Dipietro wrote:
> > > On CPUs with weak memory models, reads and updates performed by tcp_p=
ush to the
> > > sk variables can get reordered leaving the socket throttled when it s=
hould not.
> > > The tasklet running tcp_wfree() may also not observe the memory updat=
es in time
> > > and will skip flushing any packets throttled by tcp_push(), delaying =
the sending.
> > > This can pathologically cause 40ms extra latency due to bad interacti=
ons with
> > > delayed acks.
> > >=20
> > > Adding a memory barrier in tcp_push before the sk_wmem_alloc read rem=
oves the
> > > bug, similarly to the previous commit bf06200e732d ("tcp: tsq: fix no=
nagle
> > > handling"). smp_mb__after_atomic() is used to not incur in unnecessar=
y overhead
> > > on x86 since not affected.
> > >=20
> > > Patch has been tested using an AWS c7g.2xlarge instance with Ubuntu 2=
2.04 and
> > > Apache Tomcat 9.0.83 running the basic servlet below:
> > >=20
> > > import java.io.IOException;
> > > import java.io.OutputStreamWriter;
> > > import java.io.PrintWriter;
> > > import javax.servlet.ServletException;
> > > import javax.servlet.http.HttpServlet;
> > > import javax.servlet.http.HttpServletRequest;
> > > import javax.servlet.http.HttpServletResponse;
> > >=20
> > > public class HelloWorldServlet extends HttpServlet {
> > >     @Override
> > >     protected void doGet(HttpServletRequest request, HttpServletRespo=
nse response)
> > >       throws ServletException, IOException {
> > >         response.setContentType("text/html;charset=3Dutf-8");
> > >         OutputStreamWriter osw =3D new OutputStreamWriter(response.ge=
tOutputStream(),"UTF-8");
> > >         String s =3D "a".repeat(3096);
> > >         osw.write(s,0,s.length());
> > >         osw.flush();
> > >     }
> > > }
> > >=20
> > > Load was applied using wrk2 (https://github.com/kinvolk/wrk2) from an=
 AWS
> > > c6i.8xlarge instance. Before the patch an additional 40ms latency fro=
m P99.99+
> > > values is observed while, with the patch, the extra latency disappear=
s.
> > >=20
> > > # No patch and tcp_autocorking=3D1
> > > ./wrk -t32 -c128 -d40s --latency -R10000  http://172.31.60.173:8080/h=
ello/hello
> > >   ...
> > >  50.000%    0.91ms
> > >  75.000%    1.13ms
> > >  90.000%    1.46ms
> > >  99.000%    1.74ms
> > >  99.900%    1.89ms
> > >  99.990%   41.95ms  <<< 40+ ms extra latency
> > >  99.999%   48.32ms
> > > 100.000%   48.96ms
> > >=20
> > > # With patch and tcp_autocorking=3D1
> > > ./wrk -t32 -c128 -d40s --latency -R10000  http://172.31.60.173:8080/h=
ello/hello
> > >   ...
> > >  50.000%    0.90ms
> > >  75.000%    1.13ms
> > >  90.000%    1.45ms
> > >  99.000%    1.72ms
> > >  99.900%    1.83ms
> > >  99.990%    2.11ms  <<< no 40+ ms extra latency
> > >  99.999%    2.53ms
> > > 100.000%    2.62ms
> > >=20
> > > Patch has been also tested on x86 (m7i.2xlarge instance) which it is =
not
> > > affected by this issue and the patch doesn't introduce any additional
> > > delay.
> > >=20
> > > Fixes: a181ceb501b3 ("tcp: autocork should not hold first packet in w=
rite
> > > queue")
> >=20
> > Please read carefully the process documentation under
> > Documentation/process/ and specifically the netdev specific bits:
> >=20
> > no resubmissions within the 24h grace period.
> >=20
> > Please double-check your patch with checkpatch for formal errors: the
> > fixes tag must not be split across multiple lines.
> >=20
> > And please do not sent new version in reply to a previous one: it will
> > confuse the bot.
> >=20
> > > Signed-off-by: Salvatore Dipietro <dipiets@amazon.com>
> > > ---
> > >  net/ipv4/tcp.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >=20
> > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > > index ff6838ca2e58..ab9e3922393c 100644
> > > --- a/net/ipv4/tcp.c
> > > +++ b/net/ipv4/tcp.c
> > > @@ -726,6 +726,7 @@ void tcp_push(struct sock *sk, int flags, int mss=
_now,
> > >               /* It is possible TX completion already happened
> > >                * before we set TSQ_THROTTLED.
> > >                */
> > > +             smp_mb__after_atomic();
> >=20
> > Out of sheer ignorance I'm wondering if moving such barrier inside the
> > above 'if' just after 'set_bit' would suffice?
>=20
> According to the herd7 modeling tool, the answer is no for weak memory=
=20
> models.  If we put the smp_mb inside the if, it allows the machine to=20
> reorder the two reads to sk_wmem_alloc and we can get to the bad state=
=20
> this patch is fixing.  Placing it outside the if ensures=20
> the ordering between those two reads as well as ordering the write to the=
=20
> flags variable.

For the records, I asked because reading the documentation  I assumed
that smp_mb__after_atomic() enforces the ordering WRT the previous RMW
operation (in this case 'set_bit'). Is this a wrong interpretation?

Now I wonder if the patch is enough. Specifically, would it work
correctly when the TSQ_THROTTLED bit is already set and there is no RMW
operation in between the two refcount_read()?

Thanks,

Paolo


