Return-Path: <netdev+bounces-48538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4BE7EEB7B
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 04:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB4A91C2082C
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 03:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B4F6AD7;
	Fri, 17 Nov 2023 03:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="e1xFGIMR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3720B0
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 19:44:09 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a7d9d357faso16828537b3.0
        for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 19:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1700192649; x=1700797449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1ePuQaKEbVBEyGL2oQ9Z6g0u0KwHK4OBtTOmNJ9r0Kg=;
        b=e1xFGIMRpgC1wzyweJBOT5K/zLmCo/CD2zI8KIZBOVBSMAOc6Dscyn7iLj3qH7ikwm
         MgWTu3Xo3pKJz4S4zywAF05ROKbCp1LbSPUOxd7O3b54cmVnJBVFug/hEG+i7aPr+dgj
         9UTWGYIajC0I9vvCek3bLIpHCLwr5gVh13I2hoFhSCc5RM3/3iaALyfbLLa3PIPM+Wub
         t56wTUKq0la7Lma72jRqHDkCg5RLQsTz0wjzEuD4BrqXuC7B5Jh01bDa5Tu7BAF2IWgf
         TaFuCHBtllWwJO1wXeqFoWiiPFJzWjaYkpnoGMQv1MUs7T40zeJHCSi0R+r9k/rZea5y
         sMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700192649; x=1700797449;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ePuQaKEbVBEyGL2oQ9Z6g0u0KwHK4OBtTOmNJ9r0Kg=;
        b=pBQXJj2e4PMNzSVr9XmAHfptprb3apVYVk+kTq5V75lWns1f7BBD8AGFdPwaIlqDOt
         8gSTLzEQoFbpcqXbsWyjMnzhYZ/KJ7hgT4m3L01ZIvdTMoRz5JNb9AIkZa+L42heHYuh
         35kR5TED+Ph6w+gi2y10omljIR4jTlbR4Fa3NfrdXsGLot0r22gI3if5luF3f+RgneSI
         I9PZr7x+7asDRecXz3TgfZg4rWF0Uc2sQBZKx0qgVFHwZCZWN1gjuTOnccXh8BcNiqj1
         TEaNuh8+9Z4JtmbyV5FEA/5QtfAUjg92GwoE7V0bsQGkv0cRzC+iFjg6kFTIsuLz0TGy
         SZVQ==
X-Gm-Message-State: AOJu0YzC1Ej7YVozLeqjYjNXV6axOF+3VrEEXg/bFQvwKhhNxHzU74+L
	2FXU9Gexsto7QvMlVtYGp95SqmkFsSSQvKhZPuPNpw==
X-Google-Smtp-Source: AGHT+IGsnX6YOqeLTskwTfeRNXOv6+Mknt5jlqSHWpn1Kwm5S09yHR6DabgD/rza8J428jPc1uMIdQ==
X-Received: by 2002:a05:690c:3393:b0:5a7:c8d4:c254 with SMTP id fl19-20020a05690c339300b005a7c8d4c254mr19226629ywb.0.1700192648674;
        Thu, 16 Nov 2023 19:44:08 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id ei8-20020a056a0080c800b00692b2a63cccsm469733pfb.210.2023.11.16.19.44.08
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 19:44:08 -0800 (PST)
Date: Thu, 16 Nov 2023 19:44:06 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Subject: Fw: [Bug 218152] New: net rx interrupts causing a high load average
 on system
Message-ID: <20231116194406.369ff978@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Report of high cpu usage, maybe RT related

Begin forwarded message:

Date: Thu, 16 Nov 2023 06:20:25 +0000
From: bugzilla-daemon@kernel.org
To: stephen@networkplumber.org
Subject: [Bug 218152] New: net rx interrupts causing a high load average on system


https://bugzilla.kernel.org/show_bug.cgi?id=218152

            Bug ID: 218152
           Summary: net rx interrupts causing a high load average on
                    system
           Product: Networking
           Version: 2.5
          Hardware: ARM
                OS: Linux
            Status: NEW
          Severity: high
          Priority: P3
         Component: IPV4
          Assignee: stephen@networkplumber.org
          Reporter: rhmcruiser@gmail.com
        Regression: No

-> Specifically the net rx load is observed to cause a high load average on the  
system running kernel 5.15.93-rt58 as compared to 4.9.214.   
-> When checking the net rx interrupts they seems to quite high as compared to  
similar workloads running on 4.9.214-rt137-g1fc72f4. ( I mean I tested with
same hardware for both kernels).

=> Note: When all ifaces are made down or disconnected from network, load  
average drops from 1.4 to 0.2 or 0.1 , so most of the load is induced by net rx
interrupts in some manner. 

Is there any known issue reported on 5.15.93-xx specific to net rx handling
that causes this load ? 

Environment: kernel 5.15.93-rt58
Hardware: ARM 


Observations of high load on 5.15.93-rt58

# cat /proc/interrupts
           CPU0       CPU1       
 25:          0          0     GICv2  29 Level     arch_timer
 26:    3696358    3059507     GICv2  30 Level     arch_timer
 31:          0          0     GICv2 196 Edge      arm-irq1
 32:          0          0     GICv2 197 Edge      arm-irq2
 35:      96168          0     GICv2 107 Level     fsl-ifc           
 36:        128          0     GICv2 126 Level     mmc0
 39:       5343          0     GICv2 120 Level     2180000.i2c
 41:          0          0     GICv2 130 Level     gpio-cascade
 42:          0          0     GICv2 131 Level     gpio-cascade
 43:          0          0     GICv2 132 Level     gpio-cascade
 44:          0          0     GICv2 198 Level     gpio-cascade
 46:        428          0     GICv2 112 Level     fsl-lpuart
 47:      45740          0     GICv2 113 Level     fsl-lpuart       
 49:          0          0     GICv2 147 Level     2ad0000.watchdog
 50:          0          0     GICv2 167 Level     eDMA
 54:      17218          0     GICv2 158 Level     can0
 55:          0          0     GICv2 203 Level     fsl-usb2-udc
 56:       4436          0     GICv2 125 Level     xhci-hcd:usb1
 58:          0          0     GICv2 123 Level     aerdrv
 59:    1251756          0       MSI 524288 Edge      xdma
 60:       6987          0     GICv2 176 Level     eth0_g0_tx
 61:     389169          0     GICv2 177 Level     eth0_g0_rx          <<<<< RX
interrupts 
 62:          0          0     GICv2 178 Level     eth0_g0_er
 63:       1838          0     GICv2 179 Level     eth0_g1_tx
 64:          0          0     GICv2 180 Level     eth0_g1_rx
 65:          0          0     GICv2 181 Level     eth0_g1_er
 72:        263          0     GICv2 135 Level     1710000.jr
 73:          0          0     GICv2 136 Level     1720000.jr
 74:          0          0     GICv2 137 Level     1730000.jr
 75:          0          0     GICv2 138 Level     1740000.jr
IPI0:          0          0  CPU wakeup interrupts
IPI1:          0          0  Timer broadcast interrupts
IPI2:    1254818    1669575  Rescheduling interrupts                   <<<<<<   
IPI3:      97630      21898  Function call interrupts
IPI4:          0          0  CPU stop interrupts
IPI5:     109629      83567  IRQ work interrupts
IPI6:          0          0  completion interrupts



# top 

top - 06:46:03 up 32 min,  1 user,  load average: 1.44, 1.36, 1.19
                                                 
^^^^^^^^^--------------->>>>>>>> load avg over 1 5 and 15 mins  ( 2 CPU system) 
Tasks: 142 total,   1 running, 141 sleeping,   0 stopped,   0 zombie
%Cpu(s):  0.5 us,  2.5 sy,  0.0 ni, 97.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
MiB Mem :   1001.9 total,    336.0 free,    521.5 used,    144.4 buff/cache
MiB Swap:      0.0 total,      0.0 free,      0.0 used.    446.4 avail Mem 


# cat /proc/cpuinfo
processor       : 0
model name      : ARMv7 Processor rev 5 (v7l)
BogoMIPS        : 25.00
Features        : half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva idivt
vfpd32 lpae evtstrm
CPU implementer : 0x41
CPU architecture: 7
CPU variant     : 0x0
CPU part        : 0xc07
CPU revision    : 5

processor       : 1
model name      : ARMv7 Processor rev 5 (v7l)
BogoMIPS        : 25.00
Features        : half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva idivt
vfpd32 lpae evtstrm
CPU implementer : 0x41
CPU architecture: 7
CPU variant     : 0x0
CPU part        : 0xc07
CPU revision    : 5

Hardware        : Freescale LS1021A
Revision        : 0000
Serial          : 0000000000000000
#

==> Nothing cumbersome in the iptables rules, are minimal   

root@ls1021atwr:~# iptables -S
-P INPUT ACCEPT
-P FORWARD ACCEPT
-P OUTPUT ACCEPT
-A INPUT -i eth0 -p tcp -m tcp --dport 80 -j DROP
-A INPUT -i eth1 -p tcp -m tcp --dport 80 -j DROP
-A INPUT -i bt0 -p tcp -m tcp --dport 80 -j DROP
-A INPUT -i rsi_wlan -p tcp -m tcp --dport 80 -j DROP
-A INPUT -i ppp0 -p tcp -m tcp --dport 80 -j DROP
root@ls1021atwr:~#


==== LOAD AVERAGE WHEN NET IFACES ARE brought DOWN 

Load average dropped from 1.44 to 0.06 


top - 06:20:09 up  1:59,  1 user,  load average: 0.06, 0.45, 0.86             
<<<<<< 
Tasks: 149 total,   1 running, 148 sleeping,   0 stopped,   0 zombie
%Cpu(s):  4.8 us, 11.9 sy,  0.0 ni, 83.3 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
MiB Mem :   1003.9 total,    396.0 free,    529.6 used,     78.2 buff/cache
MiB Swap:      0.0 total,      0.0 free,      0.0 used.    452.9 avail Mem

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
 5865 root      20   0    3008   1716   1484 R  16.7   0.2   0:00.05 top
  760 root      -3   0    9716   3916   3424 S   5.6   0.4   0:17.46 smp
    1 root      20   0    1780    476    428 S   0.0   0.0   0:09.23 init
    2 root      20   0       0      0      0 S   0.0   0.0   0:00.02 kthreadd
    3 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 rcu_gp
    4 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 rcu_par_gp
    5 root       0 -20       0      0      0 I   0.0   0.0   0:00.00
slub_flushwq
    7 root       0 -20       0      0      0 I   0.0   0.0   0:00.00
kworker/0:0H-events_highpri
    9 root       0 -20       0      0      0 I   0.0   0.0   0:00.00
mm_percpu_wq
   10 root      20   0       0      0      0 S   0.0   0.0   0:00.00
rcu_tasks_kthre
   11 root      20   0       0      0      0 S   0.0   0.0   0:00.00
rcu_tasks_rude_

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.

