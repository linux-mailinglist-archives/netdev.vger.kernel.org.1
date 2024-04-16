Return-Path: <netdev+bounces-88365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2398A6E3B
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 16:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DECDB279FB
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 14:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983FB12F58A;
	Tue, 16 Apr 2024 14:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJI4lRz6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9EF129A72;
	Tue, 16 Apr 2024 14:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713277634; cv=none; b=UdcEjm6IRGt3vCeob133b4zRsJoUiFyHJZm1ZiIu8pcwHe94ohC57HZcUp1KZuT/hGGrjBNhtQqZTWNqEg342T+ICsll+9eaaOEBmCwfhWLInc2FTNtR9OziRlcwrh6AeolGAa8wrYjv1S9W30b/FzXSAGwoa73/ORzVksILLG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713277634; c=relaxed/simple;
	bh=v4Q/ozGudiVH3c9ZsVw3827ceHm3OFHthkW82ZvcGsU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tIcH4GtlNqKhZChkVF+q01jX+eMX5vlHMF7xnFHmLtVllfA+VERBQF+q9vzj9AtNhDKM58Hgu1o0jI1t6CrfC4xlbHS9KM2KWSMtqTplC1JTg5jJ4NOalGosc0ELOI3s03QNJ4pNo60Yt1oTa3a3qOE1sGr1jBWhSw2KJ7aaYwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJI4lRz6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A04C113CE;
	Tue, 16 Apr 2024 14:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713277634;
	bh=v4Q/ozGudiVH3c9ZsVw3827ceHm3OFHthkW82ZvcGsU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QJI4lRz6Mn/iWctwTJTO1HBgkVxvuazJcXsI0z1+ljWedhsGgjNACjxQ0xRXE4/0d
	 4bzi7Vo/W6igHAhID4FfIxFl/NrKCHMSH/sVfPztWb8ULTHUnznPXoPbqCN6IeQlYF
	 sbBommH8Yhi9Ejnhk/D5mgBYiPH2Y1iqJghOfElBBDUqMyWAkDnoA2RieaZYh1ezfZ
	 929UuWw81+T1owdknyiz37auaxr2J7LB9bC5VXUWetXhiyqB4uTpIGo1JnGN2oGg0D
	 NQsT3xAAdBbx/8YbYtrc3zKfc7FL/oL0n9+dZSBshMdm6NCQjl79WL2v0rJNE/nWRn
	 byoqvWbuxnbpA==
Date: Tue, 16 Apr 2024 07:27:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dan Jurgens <danielj@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>, Jiri Pirko
 <jiri@nvidia.com>
Subject: Re: [PATCH net-next v3 5/6] virtio_net: Add a lock for per queue RX
 coalesce
Message-ID: <20240416072712.757d7baf@kernel.org>
In-Reply-To: <CH0PR12MB85808460795C1BC5FE4EF6A7C9082@CH0PR12MB8580.namprd12.prod.outlook.com>
References: <20240412195309.737781-1-danielj@nvidia.com>
	<20240412195309.737781-6-danielj@nvidia.com>
	<20240412192111.7e0e1117@kernel.org>
	<CH0PR12MB85808460795C1BC5FE4EF6A7C9082@CH0PR12MB8580.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Apr 2024 03:15:34 +0000 Dan Jurgens wrote:
> Which version? It compiles for me with:
> $ clang -v
> clang version 15.0.7 (Fedora 15.0.7-2.fc37)

clang version 17.0.6 (Fedora 17.0.6-2.fc39)

allmodconfig

The combination of UNIQUE() goto and guard seems to make it unhappy:

../drivers/net/virtio_net.c:3613:3: error: cannot jump from this goto
statement to its label 3613 |                 goto out; |                 ^
../drivers/net/virtio_net.c:3615:2: note: jump bypasses initialization of variable with __attribute__((cleanup))
 3615 |         guard(spinlock)(&rq->intr_coal_lock);
      |         ^
../include/linux/cleanup.h:164:15: note: expanded from macro 'guard'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |                      ^
../include/linux/compiler.h:189:29: note: expanded from macro '__UNIQUE_ID'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
      |                             ^
./../include/linux/compiler_types.h:84:22: note: expanded from macro '__PASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^
./../include/linux/compiler_types.h:83:23: note: expanded from macro '___PASTE'
   83 | #define ___PASTE(a,b) a##b
      |                       ^
<scratch space>:18:1: note: expanded from here
   18 | __UNIQUE_ID_guard2044
      | ^
1 error generated.

