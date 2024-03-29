Return-Path: <netdev+bounces-83642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEC68933D6
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 18:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C23BF1C208DE
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 16:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9E0156225;
	Sun, 31 Mar 2024 16:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bI+U+9iL"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3781553BA
	for <netdev@vger.kernel.org>; Sun, 31 Mar 2024 16:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903211; cv=fail; b=HTMiHYqCJ+H6dQfARtd2o8uPQrgofQy+B/OBjAU711SFwC7kn146wqyCbGCK9AswIPYmoXhXv7VRdm0exUUu9BqkDTwTbqhYGAOxi4w+c86SKq1J5w+B5msjJvqDw69RLzwDhiaYKvgJmo/x33UM87it7avYVRpHNQjXTAZqEWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903211; c=relaxed/simple;
	bh=vAd4VNVK6PblnfwIfZw8GtveIAhGkjEecIzRPhNhibE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YsI0svMXBj/dnhTssgC8874rJSgoO4oE8cQBbUCDCAzzOh0HTHnGDsn74pP4BmGm9zu/0ZgYIhihs9DMUGhUGNnU2fUtK+mRoXjWRwUopWctYzn+/td3xP1lwchG2nAd1DFu4z81mlw4P6EBxxolqPw9aAZW9lHr/Ud87Aj1LmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; dkim=fail (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bI+U+9iL reason="signature verification failed"; arc=none smtp.client-ip=10.30.226.201; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 915EA208BF;
	Sun, 31 Mar 2024 18:40:06 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wytEcy6P3C4P; Sun, 31 Mar 2024 18:40:05 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id ECD4B2083B;
	Sun, 31 Mar 2024 18:40:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com ECD4B2083B
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id DA23B800050;
	Sun, 31 Mar 2024 18:40:00 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:40:00 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:36:17 +0000
X-sender: <netdev+bounces-83467-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com>
 ORCPT=rfc822;steffen.klassert@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAPDFCS25BAlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4YwUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAHQAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAwAAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9ye
	TogRmFsc2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAx0emlidQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2VjdW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwAAAAAABQAFAAIAAQUAYgAKAKAAAADMigAABQBkAA8AAwAAAEh1Yg==
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 10886
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.48.161; helo=sy.mirrors.kernel.org; envelope-from=netdev+bounces-83467-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 57E7F2036C
Authentication-Results: b.mx.secunet.com;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bI+U+9iL"
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711748801; cv=none; b=hLKYXnQEay5o+2wB5f0ryqS+rZ4ZW/pWleHMXwjhbqTEO9laLXYaP0C6ZTYGVrNw+Tt5OVQ/RQaNUat82Rt+EhBBWWqzcvErd7KDsFj0u4E1bDi1tepghJvI1eyyM+7gjw9B2Jl5hWUWRNj3KHwymj9hNAeWQKdXyYcIelmzd6g=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711748801; c=relaxed/simple;
	bh=WYrLnd5VJ+w8tGoOoxXgy3WX373NxHkTc+nBr5+yjG4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Da0PmiKj4OjIEt8CupTNYdDoBOgmm/fmvFKxeKWlbCItOgbA0gtxxxkd4hPTd3TIzWfN6pUedIOpwdyyZE0XgLyjFKerPpbHIyQsmI5+UNZ2pzKJU7SOGYeO/z+jep+WWfr4R1gtnmwquWEj0SLan7cV63m1nEY70J0ZSUYgjHc=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bI+U+9iL; arc=none smtp.client-ip=10.30.226.201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711748800;
	bh=WYrLnd5VJ+w8tGoOoxXgy3WX373NxHkTc+nBr5+yjG4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bI+U+9iL3hiAq1i9X3EfgmszunTmib3XIbrxUXRflu3eiFNobwQTe80Nf79MnqiG8
	 t3e98Rgu7Jq4Mk3ZE4Fdq4v43fw9On7zw5k3qEWPs63RVIGvHxkkIqzruRT0wC46jl
	 9q2y63dRk0GsdQxnFxFqQ44B8lisQgn22oS7gpVRPtSnINNdrbZMtXLzpz7n7rYzER
	 WwmL/vzkFrdHEj9I9WpPRcCiHv3J4pPbcwn/oyA4gO058KPdy3NpRp992LZOHjmd3M
	 ax2/pQcD7XZi71fGhCFm+oewMT3YFpCaojmdBqcEOVTku7zALR43tPlo8iANKnkNbS
	 495lKCzcWHj0w==
Date: Fri, 29 Mar 2024 14:46:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>, Pablo Neira Ayuso
 <pablo@netfilter.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko
 <jiri@resnulli.us>, Jacob Keller <jacob.e.keller@intel.com>, Stanislav
 Fomichev <sdf@google.com>, donald.hunter@redhat.com, fw@strlen.de
Subject: Re: [PATCH net-next v1 2/2] tools/net/ynl: Add multi message
 support to ynl
Message-ID: <20240329144639.0b42dc19@kernel.org>
In-Reply-To: <CAD4GDZw0RW3B2n5vC-q-XLpQ_bCg0iP13qvOa=cjK37CPLJsKg@mail.gmail.com>
References: <20240327181700.77940-1-donald.hunter@gmail.com>
	<20240327181700.77940-3-donald.hunter@gmail.com>
	<20240328175729.15208f4a@kernel.org>
	<m234s9jh0k.fsf@gmail.com>
	<20240329084346.7a744d1e@kernel.org>
	<m2plvcj27b.fsf@gmail.com>
	<CAD4GDZw0RW3B2n5vC-q-XLpQ_bCg0iP13qvOa=cjK37CPLJsKg@mail.gmail.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Fri, 29 Mar 2024 21:01:09 +0000 Donald Hunter wrote:
> There's no response for 'batch-begin' or 'batch-end'. We may need a
> per op spec property to tell us if a request will be acknowledged.

:(

Pablo, could we possibly start processing the ACK flags on those
messages? Maybe the existing user space doesn't set ACK so nobody
would notice?

I don't think the messages are otherwise marked as special from 
the "netlink layer" perspective.

> > I think this was a blind spot on my part because nftables doesn't
> > support batch for get operations:
> >
> > https://elixir.bootlin.com/linux/latest/source/net/netfilter/nf_tables_api.c#L9092
> >
> > I'll need to try using multi for gets without any batch messages and see how
> > everything behaves.  
> 
> Okay, so it can be made to work. Will incorporate into the next revision:

Great!

X-sender: <netdev+bounces-83467-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com> ORCPT=rfc822;peter.schumann@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-dresden-01.secunet.de
X-ExtendedProps: BQBjAAoA+UemlidQ3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.199
X-EndOfInjectedXHeaders: 8081
Received: from mbx-dresden-01.secunet.de (10.53.40.199) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Fri, 29 Mar 2024 22:46:52 +0100
Received: from b.mx.secunet.com (62.96.220.37) by cas-essen-02.secunet.de
 (10.53.40.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 29 Mar 2024 22:46:52 +0100
Received: from localhost (localhost [127.0.0.1])
	by b.mx.secunet.com (Postfix) with ESMTP id 2117320396
	for <peter.schumann@secunet.com>; Fri, 29 Mar 2024 22:46:52 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -3.099
X-Spam-Level:
X-Spam-Status: No, score=-3.099 tagged_above=-999 required=2.1
	tests=[BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099, DKIM_SIGNED=0.1,
	DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, MAILING_LIST_MULTI=-1,
	RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001]
	autolearn=ham autolearn_force=no
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=pass (2048-bit key) header.d=kernel.org
Received: from b.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lWTysdRw2TI3 for <peter.schumann@secunet.com>;
	Fri, 29 Mar 2024 22:46:51 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.48.161; helo=sy.mirrors.kernel.org; envelope-from=netdev+bounces-83467-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 6BFD82032C
Authentication-Results: b.mx.secunet.com;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bI+U+9iL"
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by b.mx.secunet.com (Postfix) with ESMTPS id 6BFD82032C
	for <peter.schumann@secunet.com>; Fri, 29 Mar 2024 22:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20389B21C05
	for <peter.schumann@secunet.com>; Fri, 29 Mar 2024 21:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A40D13BC09;
	Fri, 29 Mar 2024 21:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bI+U+9iL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA80785926
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 21:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711748801; cv=none; b=hLKYXnQEay5o+2wB5f0ryqS+rZ4ZW/pWleHMXwjhbqTEO9laLXYaP0C6ZTYGVrNw+Tt5OVQ/RQaNUat82Rt+EhBBWWqzcvErd7KDsFj0u4E1bDi1tepghJvI1eyyM+7gjw9B2Jl5hWUWRNj3KHwymj9hNAeWQKdXyYcIelmzd6g=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711748801; c=relaxed/simple;
	bh=WYrLnd5VJ+w8tGoOoxXgy3WX373NxHkTc+nBr5+yjG4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Da0PmiKj4OjIEt8CupTNYdDoBOgmm/fmvFKxeKWlbCItOgbA0gtxxxkd4hPTd3TIzWfN6pUedIOpwdyyZE0XgLyjFKerPpbHIyQsmI5+UNZ2pzKJU7SOGYeO/z+jep+WWfr4R1gtnmwquWEj0SLan7cV63m1nEY70J0ZSUYgjHc=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bI+U+9iL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BAFCC433C7;
	Fri, 29 Mar 2024 21:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711748800;
	bh=WYrLnd5VJ+w8tGoOoxXgy3WX373NxHkTc+nBr5+yjG4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bI+U+9iL3hiAq1i9X3EfgmszunTmib3XIbrxUXRflu3eiFNobwQTe80Nf79MnqiG8
	 t3e98Rgu7Jq4Mk3ZE4Fdq4v43fw9On7zw5k3qEWPs63RVIGvHxkkIqzruRT0wC46jl
	 9q2y63dRk0GsdQxnFxFqQ44B8lisQgn22oS7gpVRPtSnINNdrbZMtXLzpz7n7rYzER
	 WwmL/vzkFrdHEj9I9WpPRcCiHv3J4pPbcwn/oyA4gO058KPdy3NpRp992LZOHjmd3M
	 ax2/pQcD7XZi71fGhCFm+oewMT3YFpCaojmdBqcEOVTku7zALR43tPlo8iANKnkNbS
	 495lKCzcWHj0w==
Date: Fri, 29 Mar 2024 14:46:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>, Pablo Neira Ayuso
 <pablo@netfilter.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko
 <jiri@resnulli.us>, Jacob Keller <jacob.e.keller@intel.com>, Stanislav
 Fomichev <sdf@google.com>, donald.hunter@redhat.com, fw@strlen.de
Subject: Re: [PATCH net-next v1 2/2] tools/net/ynl: Add multi message
 support to ynl
Message-ID: <20240329144639.0b42dc19@kernel.org>
In-Reply-To: <CAD4GDZw0RW3B2n5vC-q-XLpQ_bCg0iP13qvOa=cjK37CPLJsKg@mail.gmail.com>
References: <20240327181700.77940-1-donald.hunter@gmail.com>
	<20240327181700.77940-3-donald.hunter@gmail.com>
	<20240328175729.15208f4a@kernel.org>
	<m234s9jh0k.fsf@gmail.com>
	<20240329084346.7a744d1e@kernel.org>
	<m2plvcj27b.fsf@gmail.com>
	<CAD4GDZw0RW3B2n5vC-q-XLpQ_bCg0iP13qvOa=cjK37CPLJsKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-Path: netdev+bounces-83467-peter.schumann=secunet.com@vger.kernel.org
X-MS-Exchange-Organization-OriginalArrivalTime: 29 Mar 2024 21:46:52.1893
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: e724de8b-c62a-42f5-a116-08dc5039bea9
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.37
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.202
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-02.secunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=cas-essen-02.secunet.de:TOTAL-FE=0.008|SMR=0.008(SMRPI=0.006(SMRPI-FrontendProxyAgent=0.006));2024-03-29T21:46:52.198Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-essen-02.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-02.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-OriginalSize: 7533
X-MS-Exchange-Organization-Transport-Properties: DeliveryPriority=Low
X-MS-Exchange-Organization-Prioritization: 2:ShadowRedundancy
X-MS-Exchange-Organization-IncludeInSla: False:ShadowRedundancy

On Fri, 29 Mar 2024 21:01:09 +0000 Donald Hunter wrote:
> There's no response for 'batch-begin' or 'batch-end'. We may need a
> per op spec property to tell us if a request will be acknowledged.

:(

Pablo, could we possibly start processing the ACK flags on those
messages? Maybe the existing user space doesn't set ACK so nobody
would notice?

I don't think the messages are otherwise marked as special from 
the "netlink layer" perspective.

> > I think this was a blind spot on my part because nftables doesn't
> > support batch for get operations:
> >
> > https://elixir.bootlin.com/linux/latest/source/net/netfilter/nf_tables_api.c#L9092
> >
> > I'll need to try using multi for gets without any batch messages and see how
> > everything behaves.  
> 
> Okay, so it can be made to work. Will incorporate into the next revision:

Great!


