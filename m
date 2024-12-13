Return-Path: <netdev+bounces-151806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCA89F0F75
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 15:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B83F165334
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 14:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7F71DFE33;
	Fri, 13 Dec 2024 14:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ekRELaAo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAA08F5E
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 14:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734101233; cv=none; b=tPbJEdsApg3XFNwU/3h3UGC9iYC9h0+18x3GMO8cm5h/ZyCEEmVwHcQ7lxolVaUi56IjDGqrj+o9PAdOR613CzylgYj3qsRkGuSnJs2uL88KuHJPSl64ux2dxjS56YwFXoDvLPp/dQVIX+eAZS7kX9bTMheB1KckzjBcPga3HrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734101233; c=relaxed/simple;
	bh=apVgWRRZ1FN/tqr3+d7/4ql/3RO/Kndh/W7pejY8N1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pgyg26D8TlB4ppgmWXd/XFXdk5a4rCzSAh29GmrkDkEA0h/3Bq+r2VKJMyvnbwonbXxFjoGWC6ULC4wU5JkLVWSYskCG7wNuhnr3Q6v4cloYbSAe1xiG9NVl12xe+UW198mIF6q9QvGCXBCNtRwgRJ6pbeFqOOaj5cAJtlfFePY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ekRELaAo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734101230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yWA1fUWa6COmhcE81xL9kw0/YAMY115XF84wWLlioPk=;
	b=ekRELaAos+U06OebB5mzJbICcsvYl9+Qo+IRRvmT04LeEZu3IS+rdmDo+kPPZckTCRyDnG
	oZ8KvLNrDcVqnHyzNAbYDJKz88qfmMPGon9e7klM7o/FPkt0XmX02ctyNh629b1j46zW94
	EPiQgLFdvw5kyn2E9B5w6c8YrNEyEGI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-0X1EZb14OVynRzXKCcoa7Q-1; Fri, 13 Dec 2024 09:47:08 -0500
X-MC-Unique: 0X1EZb14OVynRzXKCcoa7Q-1
X-Mimecast-MFC-AGG-ID: 0X1EZb14OVynRzXKCcoa7Q
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4679fc5c542so26155561cf.0
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 06:47:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734101228; x=1734706028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWA1fUWa6COmhcE81xL9kw0/YAMY115XF84wWLlioPk=;
        b=hdzX8gpPilwxKNbW4/kesZDNPbanfdYjfr6z7zPP/YPWWBKlYb9YpK3+we5G9F+u2S
         klSHRBVvAm/an95+Vzzvs16ni5qRtswIIjPmQCQ5+bfWItqEe3ywQxA8DwHSto7BuQsK
         MV6tJyIc88TuyMi/0WkqAD88o8FvETrDzo8k8BB7QRidO5KvAH12tyuWqXxJZdG78roV
         tCcS4QKLplvxDF1B48q4qMJKT7hk/5bE8PCU09wri0VQbUvUdYdkpkkFTKJWZ7SG/vZ6
         DB1SLn1y7jLTHahF6sMEh2N7GOiwe7ZULMLIr42iAeCBxh9lVlJgs+Qwk3DjRTelS0u+
         yWXQ==
X-Gm-Message-State: AOJu0YyinNlFEaCH7XYpnWuG4jPPDV6nW+iXC9CcS5+U0QlagflMAKpt
	UpkCLtIHzUvQye0AZOVIRNbQD8JtSh6GI6LEsXmUwTpFAVlvlT87Hj23JZTdZdjnL+4wDTxv6DA
	9g8Zg9+oTYpW4j8W5wTufQAovkkB8U51vQ9bh864/iCHAOyVNMR5Xku9iQwVnfFuz
X-Gm-Gg: ASbGncsmUMJimxRqH99svwX2B/xTDH5nxPt9zZeZ3QNebCJGMza8JupU1PeLt3S9YGB
	nsO6ia70wFZ3SVVuq2e28aT5vIv35yqa/tGW/3RWFvOCRV5+JG2FpRbEOMzRlL3OfCI4YC/eTeD
	LDK819b1LtAypOT40zAwiJUSMXXQcpqP938e+HKvayGYcEwhds4TI5cz3g0aVCTH/9r2B5dX6ix
	fBd4LnInsuPVtx4wjZ4KgJWoDrlRQH5sXkkOSDPspAHG9ucOVxkFIMkstDlH30JmzmtEoD/ed8p
	AykE/9n0AcBY6Pn7ButVhC9+e2N5WW6e
X-Received: by 2002:ac8:5fc2:0:b0:466:90b9:923a with SMTP id d75a77b69052e-467a585297cmr40916511cf.54.1734101228180;
        Fri, 13 Dec 2024 06:47:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTggynSLO95Ll+NKKeeXWtJ6cn4p4kFlwfTAC7x/wv7dleYplJofdcxcksI98Xv0OUg2JBQw==
X-Received: by 2002:ac8:5fc2:0:b0:466:90b9:923a with SMTP id d75a77b69052e-467a585297cmr40916261cf.54.1734101227847;
        Fri, 13 Dec 2024 06:47:07 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-185-21.business.telecomitalia.it. [87.12.185.21])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4679719efa8sm20653831cf.73.2024.12.13.06.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 06:47:07 -0800 (PST)
Date: Fri, 13 Dec 2024 15:47:01 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] vsock/test: Add test for accept_queue
 memory leak
Message-ID: <ghjvsagimzpok2ybcuo35t2bny3qsewl5xnbepur3b7f46ka6n@7horausgutui>
References: <20241206-test-vsock-leaks-v1-0-c31e8c875797@rbox.co>
 <20241206-test-vsock-leaks-v1-2-c31e8c875797@rbox.co>
 <uyzzicjukysdqzf5ls5s5qp26hfqgrwjz4ahbnb6jp36lzazck@67p3eejksk56>
 <a8fa27ad-b1f5-4565-a3db-672f5b8a119a@rbox.co>
 <jep457tawmephttltjbohtqx57z63auoshgeolzhacz7j7rwra@z2uqfegja6dm>
 <0bf61281-b82c-4699-9209-bf88ea9fdec5@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <0bf61281-b82c-4699-9209-bf88ea9fdec5@rbox.co>

On Fri, Dec 13, 2024 at 03:27:53PM +0100, Michal Luczaj wrote:
>On 12/13/24 12:55, Stefano Garzarella wrote:
>> On Thu, Dec 12, 2024 at 11:12:19PM +0100, Michal Luczaj wrote:
>>> On 12/10/24 17:18, Stefano Garzarella wrote:
>>>> [...]
>>>> What about using `vsock_stream_connect` so you can remove a lot of
>>>> code from this function (e.g. sockaddr_vm, socket(), etc.)
>>>>
>>>> We only need to add `control_expectln("LISTENING")` in the server which
>>>> should also fix my previous comment.
>>>
>>> Sure, I followed your suggestion with
>>>
>>> 	tout = current_nsec() + ACCEPTQ_LEAK_RACE_TIMEOUT * NSEC_PER_SEC;
>>> 	do {
>>> 		control_writeulong(RACE_CONTINUE);
>>> 		fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>>> 		if (fd >= 0)
>>> 			close(fd);
>>
>> I'd do
>> 		if (fd < 0) {
>> 			perror("connect");
>> 			exit(EXIT_FAILURE);
>> 		}
>> 		close(fd);
>
>I think that won't fly. We're racing here with close(listener), so a
>failing connect() is expected.

Oh right!
If it doesn't matter, fine with your version, but please add a comment
there, otherwise we need another barrier with control messages.

Or another option is to reuse the control message we already have to
close the previous listening socket, so something like this:

static void test_stream_leak_acceptq_server(const struct test_opts *opts)
{
	int fd = -1;

	while (control_readulong() == RACE_CONTINUE) {
		/* Close the previous listening socket after receiving
		 * a control message, so we are sure the other side
		 * already connected.
		 */
		if (fd >= 0)
			close(fd);
		fd = vsock_stream_listen(VMADDR_CID_ANY, opts->peer_port);
		control_writeln("LISTENING");
	}

	if (fd >= 0)
		close(fd);
}

Thanks,
Stefano


