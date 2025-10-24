Return-Path: <netdev+bounces-232561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBD9C06920
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 15:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0D221C07C79
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 13:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE9E320A08;
	Fri, 24 Oct 2025 13:50:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5F1320A1D;
	Fri, 24 Oct 2025 13:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761313829; cv=none; b=guJ540mAvQkR2Q4F+d2C4OKNh0apVf5KCQGT31Dr2mJlAZkUYZJVPKZokfjpTf6fmIVDt0WWAh5FKcBLmGOjm/HuHhnAzYdPzwHXOi1kKrMa7tFxGAiL3VVzJUZaxFQX0pigJJNrQC0A20oxmWFJCYKNNSk7h9YbsnELAi5jQiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761313829; c=relaxed/simple;
	bh=Wp3oKnLMc7+NFDvXDfEV5x3xIIDxOQsiOuZCMzz3tFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clOC6/Bk/U739fluEwbC7YNpdyhjq97kkeDkjg3Qk4rtSXMhLBNWoxZYQbnTP2mgWBRzs98ZjkxFBfMgymFzSZduk0LH47MwItQHHlhRPHTVCQGtQSaRTvk9yPYwuZlwRuXZasM5SvtAVKHmVvHlQAL3DIlyRvV111BArDmK+FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2EF81175A;
	Fri, 24 Oct 2025 06:50:19 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F7633F63F;
	Fri, 24 Oct 2025 06:50:24 -0700 (PDT)
Date: Fri, 24 Oct 2025 14:50:21 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Adam Young <admiyo@amperemail.onmicrosoft.com>
Cc: Adam Young <admiyo@os.amperecomputing.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>, Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH v30 2/3] mailbox: pcc: functions for reading and writing
 PCC extended data
Message-ID: <20251024-resilient-sawfly-of-joy-33dcdc@sudeepholla>
References: <20251016210225.612639-1-admiyo@os.amperecomputing.com>
 <20251016210225.612639-3-admiyo@os.amperecomputing.com>
 <20251020-honored-cat-of-elevation-59b6c4@sudeepholla>
 <78c30517-4b16-4929-b10b-917da68ff01c@amperemail.onmicrosoft.com>
 <aPeSfQ_Vd0bjW-iS@bogus>
 <3ae91e09-2f52-4ca4-b459-3b765a3cad0c@amperemail.onmicrosoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ae91e09-2f52-4ca4-b459-3b765a3cad0c@amperemail.onmicrosoft.com>

On Tue, Oct 21, 2025 at 01:20:50PM -0400, Adam Young wrote:

[...]

> > > Because the PCC spec is wonky.
> > > https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/14_Platform_Communications_Channel/Platform_Comm_Channel.html#extended-pcc-subspace-shared-memory-region
> > > 
> > > "Length of payload being transmitted including command field."  Thus in
> > > order to copy all of the data, including  the PCC header, I need to drop the
> > > length (- sizeof(u32) ) and then add the entire header. Having all the PCC
> > > data in the buffer allows us to see it in networking tools. It is also
> > > parallel with how the messages are sent, where the PCC header is written by
> > > the driver and then the whole message is mem-copies in one io/read or write.
> > > 
> > No you have misread this part.
> > Communication subspace(only part and last entry in shared memory at offset of
> > 16 bytes) - "Memory region for reading/writing PCC data. The maximum size of
> > this region is 16 bytes smaller than the size of the shared memory region
> > (specified in the Master slave Communications Subspace structure). When a
> > command is sent to or received from the platform, the size of the data in
> > this space will be Length (expressed above) minus the 4 bytes taken up by
> > the command."
> > 
> > The keyword is "this space/region" which refers to only the communication
> > subspace which is at offset 16 bytes in the shmem.
> > 
> > It should be just length - sizeof(command) i.e. length - 4
> 
> 
> I just want to make sure I have this correct.  I want to copy the entire PCC
> buffer, not just the payload, into the sk_buff.  If I wanted the payload, I
> would use the length field.  However, I want the PCC header as well, which
> is the length field, plus sizeof (header).  But that double counts the
> command field, which is part of the header, and thus I subtract this out.  I
> think my math is correct. What you wrote would be for the case where I want
> only the PCC payload.
> 

Why ? How does sk_buff interpret that as PCC header. Something doesn't align
well here or I might be missing something.

I started writing some helpers and this comment made me to rethink my
approach. I don't have any to share and I will be away for a while. I will
try to review any further changes from you but expect delays.

-- 
Regards,
Sudeep

