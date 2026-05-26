Return-Path: <netdev+bounces-291557-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLfNAYZDFWokUAcAu9opvQ
	(envelope-from <netdev+bounces-291557-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 08:53:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3305D161B
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 08:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AECA43033AA5
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 06:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C8D3C4B8A;
	Tue, 26 May 2026 06:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TR/s+dSF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011EF3C3459
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 06:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779778394; cv=none; b=hT9M/VFnwrJETZHxbRX/KjH9ENtFUMdvwEYKMYyP10Us0WyN6xvqFa8/whLO3009OHMWLnyD1TyumwVQwxSx4DgJok+6HIpjHosjM5t8p/o00Cr7IlApoiYbqurSfXXXWnYRcBJx7NsansPegXQMSYG6Ld5tmDcvDRJ6wCvDE7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779778394; c=relaxed/simple;
	bh=lI94k3K5Kcc20pekEfGAOaAomJ1QgkYtP6G74MUe9gk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QlMMXgdXAIflrYZOpk0qlh13zPfPAx9zc/J0435IU5r3QSS6GNw82craNubKQNa7dBcIiI12eVgj/1JGk2quup+W+m3aTDDcjTtMCIb6o7jzuXb7HWtQl6edBkVQ7n+znZrSTSZEQKuTEYE+Eo34l+h60yHtwM2RJ0YfQrVkBrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TR/s+dSF; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-459bf19e87bso5943352f8f.1
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 23:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779778389; x=1780383189; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yXWASYjT/jE4WzpKhE8nVhHkzGwmPlTITkkcMF0D8BI=;
        b=TR/s+dSFI2Vk05JY9oKvhTkUPLyGjERphtpAPMGuiQxvuv3fbFSbN1th4lK+bttysm
         cFb/iWCpkNb08kRUbTcn9WjfJUaB3xcjwa8CXEuHNu8ztYYWGwWQbD8loHo0HuyuciOC
         0TwcL+CxgU01vXU93n3aCg4f5dmgC1/3cis8o9d493p1B0tb+ArlTCB5LaW6RVOHuZSe
         xFgNBY2Ddet/gPdHUxjFVULwbZSkZetwjzSKlyv7KFRavsith7RHUAc5uHnKUJqDu/G4
         H3+i6q7GH893mbCE8FjnHXqiv6/6t+5ocWoYo60XT6575r8A+rywJ8KG4tumaLrCo8Ff
         W8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779778389; x=1780383189;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yXWASYjT/jE4WzpKhE8nVhHkzGwmPlTITkkcMF0D8BI=;
        b=YZXfJbQnepMY/xHras5VsZI+ReiNrTWOpz7SOCjiOuY2mHJ/j5O/gQBpMjsvMfeSg8
         JB/6WqmfrxePPyHOOuHWMJhH6sKOj8DU/piYcL58rADw5hfc4FZhIE/pOIJAMq70YLEI
         NHV1q5xZZu3aUvdXeCJNujJam9buU2pBbNsQ9ht60V5O1xbcvWCrroh7yFwxZk4b+qBf
         uSMjHrlTC2n0P7HqSagVSFSk5ZmYpkeyA6jA2jKkZbhtERP0ZkftcobtUEoVxFalt+lS
         yHE1XzZIb8oofGHP+CzOmn7wDrBrK4iUlsIDa2V1ch1A0reakR19e85rMrf50QXC/SwU
         xQ/g==
X-Forwarded-Encrypted: i=1; AFNElJ/O1UgrHsU28W8tGcaZzVQ8Eo/lCtwEt2f4LMOOPdc4BhMmbaFKsnmHfHqXM0wI2twWCq+1QJU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/JYeDP0O21nqf9va4M850dyjUnYCGIjg1K/hinOPC5YfHXSUj
	haflSHeyvPTREzyMVLxVA6dvTWLh9fqYFE/1cSiZ2KrRfPWWKw+l0bfNWIfNhtzHnXQ=
X-Gm-Gg: Acq92OFow+bwps/ewkL0WXVZuK3tkdTiI+/YAfHzrpydjrjR/K8OMoC9VPzoNudAA91
	Jak9XkU7AkOqDVVSELsehq0A4Jt1yPS7KBOc4JIil7VE/HxZ3Ctqx1i9DMaCNJ9IA3k2u2pGPLA
	0szPIg0sYAMdHUQp4+5YEp94ZaXyYy52tr6NEpOBK27fK/JnJyVmt7K77MlqWGxxa/M3edcV4XL
	GJCQXGG+lL6wRylWuI9vpRgInMvCNvbfAqs1oAaXiqZsaR4cx4LZ+Fvf6nrHzy3Ac0MbyTUBz2m
	lUbTveUh07dfujZKNWKaBhJU3oLe9tpSh2eYSU7PLEkH4WXZ2qKJfGvIxY9i9edVnTW/8ZnkqNG
	VIiStZ1FR5na6ZeIIeBcIzqctACm66bIQ+lGgU715uucdAvK5e1zvMcAVPaJYJqMcGq6dnSZSVa
	HKMiBCgAAcgsYgKBiOFdT+RbubWjY4nF272638HvBJvpy6NhkH/6w9C7Qe0Z12de4tJ8cidcZ/3
	wVVCduqFAOLy/MRa8GnbY3aaF0rlVAlkgFHgSaep+/sV0dwGdJGhq0Ngb8WvD7LIplQM877B5gE
	4nal
X-Received: by 2002:a05:6000:2003:b0:43b:4136:1e6f with SMTP id ffacd0b85a97d-45eb38e4b46mr29516257f8f.38.1779778389230;
        Mon, 25 May 2026 23:53:09 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6c9ba2esm33848641f8f.8.2026.05.25.23.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 23:53:08 -0700 (PDT)
Message-ID: <88c5ca1d-eeda-4023-bc7a-397b92780db9@suse.com>
Date: Tue, 26 May 2026 08:53:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] Convert moduleparams to seq_buf
To: Kees Cook <kees@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Pengpeng Hou
 <pengpeng@iscas.ac.cn>, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Corey Minyard <corey@minyard.net>, Gabriel Somlo <somlo@cmu.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Bart Van Assche <bvanassche@acm.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Hannes Reinecke <hare@suse.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>,
 Tiwei Bie <tiwei.btw@antgroup.com>, Benjamin Berg <benjamin.berg@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "David E. Box" <david.e.box@linux.intel.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, John Johansen <john.johansen@canonical.com>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Georgia Garcia <georgia.garcia@canonical.com>, kvm@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-modules@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, linux-um@lists.infradead.org,
 linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
 qemu-devel@nongnu.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
 linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, netdev@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20260521133315.work.845-kees@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260521133315.work.845-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,iscas.ac.cn,nod.at,cambridgegreys.com,sipsolutions.net,minyard.net,cmu.edu,redhat.com,linux.intel.com,intel.com,ursulin.net,gmail.com,ffwll.ch,acm.org,ziepe.ca,ideasonboard.com,google.com,suse.de,HansenPartnership.com,oracle.com,arm.com,linuxfoundation.org,rowland.harvard.edu,linux.alibaba.com,akamai.com,antgroup.com,orcam.me.uk,infradead.org,linux.ibm.com,alien8.de,zytor.com,atomlin.com,linux-foundation.org,canonical.com,paul-moore.com,namei.org,hallyn.com,vger.kernel.org,googlegroups.com,kvack.org,lists.ubuntu.com,lists.infradead.org,lists.sourceforge.net,nongnu.org,lists.freedesktop.org,lists.ozlabs.org,lists.one-eyed-alien.net,lists.linux.dev];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-291557-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petr.pavlu@suse.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_GT_50(0.00)[98];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:mid,suse.com:dkim]
X-Rspamd-Queue-Id: 8F3305D161B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/21/26 3:33 PM, Kees Cook wrote:
> Hi,
> 
> I tried to trim the CC list here, but it's still pretty huge...
> 
> We've had a long-standing issue with "write to a string pointer" callbacks
> that don't bounds check the destination (and for which the bounds is
> also not part of the callback prototype, even if it is "known" to be
> PAGE_SIZE, which sysfs_emit() depends on). Both moduleparams and sysfs
> use this pattern. As a first step, and to test the migration method,
> migrate moduleparams first.
> 
> There are 2 "mechanical" treewide patches that are handled by Coccinelle:
> - treewide: Convert struct kernel_param_ops initializers to DEFINE_KERNEL_PARAM_OPS
> - treewide: Convert custom kernel_param_ops .get callbacks to seq_buf via cocci
> 
> The last treewide patch is manual, and may need to be broken up into
> per-subsystem patches, though I'd prefer to avoid this, as it would
> extend the migration from 1 relase to at least 2 releases. (1 to
> release the migration infrastructure, then 1 release to collect all the
> subsystem changes, and possibly 1 more release to remove the migration
> infrastructure.)
> 
> Thoughts, questions?

This looks reasonable to me. I added a few minor comments on the patches
but they already look solid.

-- 
Thanks,
Petr

