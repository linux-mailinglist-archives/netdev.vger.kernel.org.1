Return-Path: <netdev+bounces-64944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6698683862F
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 04:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBFAD1F24830
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 03:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41DD17EB;
	Tue, 23 Jan 2024 03:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJSBfKDE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7986D17CA
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 03:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705982182; cv=none; b=UuGuZ84jTeW3EUyy1Y/rouxe79OjAGlyxRLE/uz088QJOZ/Ff6qFEqGEGuGqM0sWRDjSt/t/Aa52/4Ss4RbCq5Zs+sTV79OUcyLW13KUCnYpMNdY8cWe7abjivYT+m0tIbg7MZHVCle2zZTMnoZHNfRJB/+6Ur63H7/Koz7+ZZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705982182; c=relaxed/simple;
	bh=tUkhzf66p59sX2eWK3M3fCET/aAa5Qmh0TwCjlkIsaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SgLBWvRDBzznZ5byela/R/hb2mbsjLvA8OKXfl+jM5GlK0wThcgA/OGS6jlV1CM9WalQoxcAcOok0cR3f2eDIofKtThmf8oDkGUEoQ0Blys02esnEVphmw7KXepxhjvpIY1RJMYAeXnVvrVRSBbvzXrGeBUTzeyBGPzp4UE3Hy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJSBfKDE; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3bbb4806f67so3344868b6e.3
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 19:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705982180; x=1706586980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A4XdXMjsTBpIdPhWLZf5I1FdwK2Re5vXlDRUKJqyOiY=;
        b=IJSBfKDE4dfhQ3G0WtR+AmybJ4QKTKCot+CTPc5mmAn8Yk58V7V4vJJaxIttsIB1n/
         jf6uwwQZ2SQO8DZXqr6nhXdmEF/8RFphx1tAQ/4y/qmUXk0xNw877ovJRKvKNpp6pGXf
         7oJy+YDRsS6mji9HX+Pp1x8o24hUItKFYUMrY1KRoMBcThuma42f9Kxy3k+b09eWjRob
         902xlkPu47Ksg0f9t5ddRlURxOORIyp7d+0lFyX5ZDOxbibJVB3oaeLnyaBkjweylTMx
         KZDMJlTGTBV4PiGWcpgAm0AJ1MUbDXO6rnpkgXk2YWOverULIX4vM4tcf4SuuB+ojPJq
         dbNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705982180; x=1706586980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4XdXMjsTBpIdPhWLZf5I1FdwK2Re5vXlDRUKJqyOiY=;
        b=xJP4bE4VokDwLEMZJuoIf0etEB56rE8g5XGSmmBWGYmh/XDgjwxAEVgw5e3IKrL19n
         kFxevbThX20V1ICTOOldxFeWGoz1lkka53oZZh3FqXMciYMTqd+s/4jckExREDFh6oX1
         q5hWYeP12d6RJKWmH3HxK0Qu6jakz/bCd8jJbz0efYF9iEfAjKtA6H57ckqObfJ/vF3k
         3gEqG7iYDs6/GotKDTyRk2EsM7fft1913CszNQNcIApjjx2PS6PPcMcyXAxW0duC9VBv
         zI+3vsdkMQ1FO/lfInTfcy0t72Q4KRAyjjnzLYFTs/GRYYG1DRoBMpOpwVEYzGTrRtre
         x9eQ==
X-Gm-Message-State: AOJu0YwEp9/x7pYyP5uOTgm4IYyvDfB8FnRMPwVD5oxiG5uetJmksBzo
	6bPlw5gllIP9Loat8kY9vAaTy3DSBl7WcwF1la/FAcVlm7IN6yT6jlwrR7h8Xi0F0A==
X-Google-Smtp-Source: AGHT+IFI3FSMperP4C1TcnY0CcNvuDs7j2iVKECoHprmRzq/l2NvPCTtZpYSCkeMTD2FUbXyJ9DYaw==
X-Received: by 2002:a05:6808:d4c:b0:3bd:c710:75e with SMTP id w12-20020a0568080d4c00b003bdc710075emr149240oik.58.1705982180019;
        Mon, 22 Jan 2024 19:56:20 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id k85-20020a628458000000b006dd7d002bf7sm53742pfd.12.2024.01.22.19.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 19:56:19 -0800 (PST)
Date: Tue, 23 Jan 2024 11:56:15 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jay.vosburgh@canonical.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Benjamin Poirier <bpoirier@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [TEST] bond_options.sh looks flaky
Message-ID: <Za8439kp8oPxwb7M@Laptop-X1>
References: <20240122135524.251b0975@kernel.org>
 <17415.1705965957@famine>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17415.1705965957@famine>

On Mon, Jan 22, 2024 at 03:25:57PM -0800, Jay Vosburgh wrote:
> Jakub Kicinski <kuba@kernel.org> wrote:
> 
> >Hi folks,
> >
> >looks like tools/testing/selftests/drivers/net/bonding/bond_options.sh
> >is a bit flaky. This error:
> >
> ># TEST: prio (balance-alb arp_ip_target primary_reselect 1)           [FAIL]
> ># Current active slave is eth2 but not eth1
> >
> >https://netdev-2.bots.linux.dev/vmksft-bonding/results/432442/7-bond-options-sh
> >
> >was gone on the next run, even tho the only difference between 
> >the content of the tree was:
> >
> >$ git diff net-next-2024-01-22--18-00..net-next-2024-01-22--21-00 --stat 
> > Documentation/devicetree/bindings/net/adi,adin.yaml | 7 ++-----
> > drivers/net/dsa/mv88e6xxx/chip.c                    | 2 +-
> > drivers/net/phy/adin.c                              | 2 --
> > 3 files changed, 3 insertions(+), 8 deletions(-)
> >
> >So definitely nothing of relevance.. 
> >
> >Any ideas?
> 
> 	I think I see a couple of things in the test logic:
> 
> 1) in bond_options.sh:
> 
> prio_arp()
> {
> 	local primary_reselect
> 	local mode=$1
> 
> 	for primary_reselect in 0 1 2; do
> 		prio_test "mode active-backup arp_interval 100 arp_ip_target ${g_ip4} primary eth1 primary_reselect $primary_reselect"
> 		log_test "prio" "$mode arp_ip_target primary_reselect $primary_reselect"
> 	done
> }
> 
> 	The above appears to always test with "mode active-backup"
> regardless of what $mode contains, but logs that $mode was tested.  The
> same is true for the prio_ns test that is just after prio_arp in
> bond_options.sh.

Ah, yes. I will post a fix for this issue.

> 
> 2) The balance-alb and balance-tlb modes don't work with the ARP
> monitor.  If the prio_arp or prio_ns tests were actually testing the
> stated $mode with arp_interval, it should never succeed.

Hmm, I forgot why I put the prio_arp/prio_ns in the mode for loop but
only use active-backup for testing... But this definitely a waste of time.
I will run them only for active-backup testing.

> 
> 3) I'm not sure why this test fails, but the prior test that claims to
> be active-backup does not, even though both appear to be actually
> testing active-backup.  The log entries for the actual "prio
> (active-backup arp_ip_target primary_reselect 1)" test start at time
> 281.913374, and differ from the failing test starting at 715.597039.

From the passed log

[  505.516927] br0: port 2(s1) entered disabled state
[  505.773009] bond0: (slave eth1): link status definitely down, disabling slave
[  505.773593] bond0: (slave eth2): making interface the new active one

While the failed log
[  723.603062] br0: port 4(s2) entered disabled state
[  723.868750] bond0: (slave eth2): link status definitely down, disabling slave
[  723.869104] bond0: (slave eth1): making interface the new active one

It looks the wrong active link was set. It should be eth1 but set to eth2.
So the later link operation set eth2 link down. Not sure why eth2 was set to
active interface. I need to print log immediately if check_err failed.

Thanks
Hangbin

