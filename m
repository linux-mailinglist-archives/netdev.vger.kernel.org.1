Return-Path: <netdev+bounces-177923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D64A72EC7
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 12:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9E777A7673
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 11:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8B7212B1F;
	Thu, 27 Mar 2025 11:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C1RHGQLr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3E5211A13
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 11:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743074473; cv=none; b=OouXW0BFCvDPM3sl95FtAq0QdsD1Zp1xoEeRVzdQN6+Tbsxguhyso6V/dzZ9ccOUjtX9HSQc6AHxJf9ytBa2MT5DkaaWNPTJE3QDD8k3uHGThiQFTlZBl+yEeDR3O6KKvRT9fCxiCEgeExgNK2KeGTUy6T2HdQvVCn6PHZjBbIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743074473; c=relaxed/simple;
	bh=3ZrnUp9Fhn9UaUnyyfKY5MriRafswzCPAWMuIe6cdA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3L2TYaZ3r7luF7/Rm58s21SKh7nNO1L8BrIjye3i7gKEORqLT4zytOElVaCOZ/rzkLOAGxkzFDhbKNfFkoV+GcGLcIkKXnrvqU+gB8394zmZJLih/1XxMQpxb0efXodaAqyf+2OFLVVhVkrONfoQsKFDe8oTOW6tjCiev46pS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C1RHGQLr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743074470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JRX5KdSGkfJSEr/WHGFbdRRh0ujs8cABCCjOijR+WkE=;
	b=C1RHGQLrDgDFe/32jw/tUggPRDvs7FySunAFbTgjMXUbqHUD5/NJ7KWLga7+i6N7550jht
	3Qxl/TQ1jw1+ASdsWNafM7BBCLaIVlcP4w5d3JEFJsFtmyhpA0O5kQrVPPJ4cwoxP+4ez2
	xJQSKKPJGnrndLpTlQvofumBfV1lB8w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-MRpFfOFwMDSjJer0fEg2tw-1; Thu, 27 Mar 2025 07:21:08 -0400
X-MC-Unique: MRpFfOFwMDSjJer0fEg2tw-1
X-Mimecast-MFC-AGG-ID: MRpFfOFwMDSjJer0fEg2tw_1743074467
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3978ef9a284so354198f8f.3
        for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 04:21:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743074467; x=1743679267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRX5KdSGkfJSEr/WHGFbdRRh0ujs8cABCCjOijR+WkE=;
        b=ReoEj3PB4Jt+jWonUUqOSrOw/T6iEDqyzhsoLdofzP/wqM+eRgKOMqXn4vioWkE8/+
         sdUW9kzR/zs5QIg73ZBaOiNzV5DlY1PIFgC3BkIS8ykMug3nRD2C8Kd5NQb8/31UrjgW
         z/DwpAHpllNU0TYVrcGAZICWew1M8CgAETn59g7DTkpilSODeaP4OjT2QOYDAtMyncKu
         QVSfiYMoXjzWyC31x/JNwQ4pYCvqVjW48eBR3XRxNpaIhc1YHQaczkYdzOkwktV0Ybs5
         6XRw4udLM+etWyIMliKPDNvHU53u3REHIyKDpYGSTz1GWuZss+PPDgTlNE7fn916iL6X
         KjnA==
X-Forwarded-Encrypted: i=1; AJvYcCUdEFX62q1b0Bmsvcflfr0O+pbkMslEqQmmOxP1E/pPtx42qq1dPvsfQYj6ckaoBevSla1IQQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YysTS4xaUL1jFSyPLWO1J5MMTqoBUP87TACNOfJ2FMSQYvGE1ag
	TF6pFnqGfHkw6J06m4vZZ56g3JixfAJ9a8vqnaE/XqYGtRNRWfDa3i4v347PtGJ3LnlMxvqaWXu
	lEh4nJ1nw79zQP3aXiwKUTYAYN5UOxQFQMehZKX2Gita0/dxSeq68qg==
X-Gm-Gg: ASbGncssmPMEKobYsTBPTt8JMSuI22zNuX2Ld6Gl4TVZ+bsaY5yfCFHexZJdyDZzmf1
	cUeU7eCYqF3rqOlyw2Cq9b0tF0aGSDS4gT3CJj3z6oJ/RwbAUsutOdPpStotUkqi4MtEw+lFkYw
	nZHEHLXv9byGinfBCiABBp0jFk6B+F3eWqGv0Itn3A2Ro2uV64SlwhJqpRwHSwmQHPOkzUUFsxW
	8cWL/flCJmsiM2LIZih/CgM+HBqdKykbQrFJdW0Gbno8GxkWzip8A888JVpn7a1pspKp/r4kPL9
	Xp7pcYH2iAJ4jUR+FJ2+uAwmqCnAYf9YmAthxO553cMpuG7PodQJh6pF/HRFZyy0
X-Received: by 2002:a05:6000:2d82:b0:390:e158:a1b8 with SMTP id ffacd0b85a97d-39ad1787adfmr2287625f8f.43.1743074467494;
        Thu, 27 Mar 2025 04:21:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2h7ayPlB4Kss3y5VeCbbDdjXM4BImGSUtzVmo6fk6xKoLcS1gfkg1jwqkOYe+guaCoI3pLg==
X-Received: by 2002:a05:6000:2d82:b0:390:e158:a1b8 with SMTP id ffacd0b85a97d-39ad1787adfmr2287591f8f.43.1743074467014;
        Thu, 27 Mar 2025 04:21:07 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-55.business.telecomitalia.it. [87.12.25.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39ac80e6814sm8150600f8f.56.2025.03.27.04.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 04:21:06 -0700 (PDT)
Date: Thu, 27 Mar 2025 12:21:02 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, syzbot <syzbot+7f3bbe59e8dd2328a990@syzkaller.appspotmail.com>, 
	eperezma@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev, oleg@redhat.com, ebiederm@xmission.com, stefanha@redhat.com, 
	brauner@kernel.org
Subject: Re: [syzbot] [kvm?] [net?] [virt?] INFO: task hung in
 __vhost_worker_flush
Message-ID: <fd77ljndgwznty4e45t7o55sbyfdlxfl7otly5ib7mjlnsxcwb@ve45z34reswm>
References: <Zr-VGSRrn0PDafoF@google.com>
 <000000000000fd6343061fd0d012@google.com>
 <Zr-WGJtLd3eAJTTW@google.com>
 <20240816141505-mutt-send-email-mst@kernel.org>
 <02862261-b7cf-44c1-8437-5e128cfd1201@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <02862261-b7cf-44c1-8437-5e128cfd1201@oracle.com>

On Mon, Aug 19, 2024 at 10:19:44AM -0500, Mike Christie wrote:
>On 8/16/24 1:17 PM, Michael S. Tsirkin wrote:
>> On Fri, Aug 16, 2024 at 11:10:32AM -0700, Sean Christopherson wrote:
>>> On Fri, Aug 16, 2024, syzbot wrote:
>>>>> On Wed, May 29, 2024, syzbot wrote:
>>>>>> Hello,
>>>>>>
>>>>>> syzbot found the following issue on:
>>>>>>
>>>>>> HEAD commit:    9b62e02e6336 Merge tag 'mm-hotfixes-stable-2024-05-25-09-1..
>>>>>> git tree:       upstream
>>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=16cb0eec980000
>>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3e73beba72b96506
>>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=7f3bbe59e8dd2328a990
>>>>>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>>>>>>
>>>>>> Unfortunately, I don't have any reproducer for this issue yet.
>>>>>>
>>>>>> Downloadable assets:
>>>>>> disk image: https://storage.googleapis.com/syzbot-assets/61b507f6e56c/disk-9b62e02e.raw.xz
>>>>>> vmlinux: https://storage.googleapis.com/syzbot-assets/6991f1313243/vmlinux-9b62e02e.xz
>>>>>> kernel image: https://storage.googleapis.com/syzbot-assets/65f88b96d046/bzImage-9b62e02e.xz
>>>>>>
>>>>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>>>>> Reported-by: syzbot+7f3bbe59e8dd2328a990@syzkaller.appspotmail.com
>>>>>
>>>>> #syz unset kvm
>>>>
>>>> The following labels did not exist: kvm
>>>
>>> Hrm, looks like there's no unset for a single subsytem, so:
>>>
>>> #syz set subsystems: net,virt
>>
>> Must be this patchset:
>>
>> https://lore.kernel.org/all/20240316004707.45557-1-michael.christie@oracle.com/
>>
>> but I don't see anything obvious there to trigger it, and it's not
>> reproducible yet...
>>
>
>Sorry, I missed the original post from May.
>
>I'm trying to replicate it now, but am not seeing it.
>
>The only time I've seen something similar is when the flush is actually waiting
>for a work item to complete, but I don't think the sysbot tests that for vsock.
>So, I think I'm hitting a race that I'm just not seeing yet. I'm just getting
>back from vacation, and will do some more testing/review this week.

Hi Mike,
looking at the syzbot virt monthly report I saw this issuse still open 
and with crashes:

   https://syzkaller.appspot.com/bug?extid=7f3bbe59e8dd2328a990

Have you had a chance to take a look?

Thanks,
Stefano


